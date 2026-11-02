---
name: kill-rewards-model
description: TLA+ model check that every killed enemy in this data pack is paid its reward (drops, exp, job exp, quest kill progress) exactly once, across real-time kills, turn-based battle, battle end, field AI and poison. Use when a change touches damage/kill, the reward lines of tick.mcfunction, battle/turn_end, proc_all, grant_reward, check_end, battle end/return, battle start, attack/damage, projectile/move, magic/aoe or magic/hit, or the order of lines in tick.mcfunction.
---

# Kill rewards model

**Promise.** An enemy that is killed and removed was paid exactly once by `test:battle/grant_reward`.
**Harm when broken.** Paid twice: duplicated drops, exp and quest progress. Paid never: the kill is lost.

The model is [KillRewards.tla](KillRewards.tla). It covers one server tick in the order of `test:tick`
(`data/test/function/tick.mcfunction`), plus player actions between ticks, for 2 enemies and one battle
instance. It checks two invariants on every reachable state:

- `AtMostOnce`: no enemy is paid twice.
- `PaidWhenRemoved`: an enemy whose entity was killed (`kill @e[tag=kill]`) had been paid.

## Run

From the repo root (about 2 s):

```bash
powershell -NoProfile -ExecutionPolicy Bypass -File .claude/skills/kill-rewards-model/run.ps1
```

The script does the following:

1. Reads 8 facts from the current `.mcfunction` files and prints them.
2. Writes them as constants.
3. Runs TLC from `tla2tools` 1.7.4. It downloads the jar to `%LOCALAPPDATA%\tlaplus\` on the first run and
   checks the jar's SHA-256.
4. Uses Java 11 or later, from `JAVA_HOME`, the Minecraft Launcher runtimes or `PATH`.

| Exit | Meaning |
| --- | --- |
| 0 | Both invariants hold. |
| 1 | A violation. TLC prints the shortest trace. |
| 2 | A fact could not be read, because the code moved. Re-read the code and update `run.ps1` and the model. |

Read every result with the pstack `/statechart` skill. For a violation it tells the shortest path in plain
words. For a pass it draws how an enemy moves between field, battle and removal.

## The facts read from code (`run.ps1`)

| Constant | Where | Pattern |
| --- | --- | --- |
| `KillTagsPending` | `damage/kill.mcfunction` | `tag=battle_member,tag=!kill] run tag @s add battle_reward_pending` |
| `KillTagsBattleKilled` | `damage/kill.mcfunction` | `tag=battle_member] run tag @s add battle_killed` |
| `FieldKillSkipsMember` / `FieldKillSkipsBattleKilled` | `tick.mcfunction`, the one line that runs `test:reward/field_kill` | `tag=!battle_member` / `tag=!battle_killed` |
| `AttackSkipsMember` | `attack/damage.mcfunction`, the line that runs `test:attack/hit_apply` | `tag=!battle_member` |
| `MagicSkipsMember` | `projectile/move.mcfunction` and `magic/aoe/apply.mcfunction` (the lines that run `test:magic/hit`), `magic/hit.mcfunction`, `magic/.mcfunction` | both hit lines have `tag=!battle_member`, or `magic/hit` returns for a `battle_member`, or the cast entry has `execute if score @s test.battle.id matches 1.. run return fail` |
| `BuffStepBeforeProcAll` / `ProcAllBeforeCheckEnd` | `battle/turn_end.mcfunction` | line order of `buff/step`, `battle/proc_all`, `battle/check_end` |

## Coverage record

Each part of the model stands for code. The parts not read automatically are written into the model by hand:

| Model part | Code |
| --- | --- |
| Tick phase order | `tick.mcfunction`: `projectile/move` (line 7), `battle/tick` (17), `field_ai/tick` (27), `buff/tick_second_all` (57), `reward/field_kill` (95), `kill @e[tag=kill]` (102) |
| `Player` | `trigger/left_click/` → `attack/`, `trigger/right_click/mainhand` → `magic/` (aoe hits at once), `attack/damage` lines 12–13 (first strike and battle start) |
| `Kill` | `damage/.mcfunction` (`if hp ..0 run function test:damage/kill`), `damage/kill.mcfunction`, `buff/on/interval/poison.mcfunction` |
| `BattleAct` / `TurnEnd` | `battle/tick` → actions → `battle/turn_end` (buff/step, proc_all, check_end), `battle/turn_skip`, `battle/action/flee` |
| proc step | `battle/proc_all.mcfunction`: `grant_reward` for `battle_reward_pending` of this battle id; `grant_reward` removes the tag |
| `EndBattle` | `battle/end`, `battle/return_member` (alive), `battle/return_member_defeated` (HP reset to max, battle_member removed, teleported into test:turn) |
| `StartBattle` | `battle/start`, `battle/setup`, `battle/enter_arena` (battle_member); `battle/field_ai/tick` only for HP ≥ 1, not battle_member |
| `Poison` | `buff/tick_second_all` (not in test:turn or test:arena) |
| `FieldKill` | `reward/field_kill` → `battle/grant_reward` |

**Last confirmed in sync at commit `24451c7`.** To find what changed since then, run
`git diff 24451c7 -- data/test/function/{tick,damage,battle,attack,projectile,magic,buff,reward}`.

Move the sync commit forward only after you have re-read every changed file in the table and confirmed
that the model still describes it.

## When a change touches the covered code

1. Run `run.ps1`. If a fact changed, the printed facts show it, and the check already follows the code.
2. If the change is in a part of the coverage table that is modelled by hand, re-read that code. Then update
   the action in `KillRewards.tla` so it does what the code now does. Examples: a new tick line that kills
   or pays, a new path that ends a battle, or a new hit path that can reach a `battle_member`. Every action
   names its code in a comment. Keep it that way.
3. Run again. Then decide what a violation is:
   - **Real bug**: every step of the trace is something the code really allows in that order. Report it in
     the code's words. Don't weaken an invariant or remove an action to make it pass.
   - **Modelling error**: a step the code cannot take, such as a kill at HP ≤ 0, or a field kill of an enemy
     whose tick line excludes it. Fix the model, and say what was wrong.
4. Update the sync commit (see above).

## Past finding (fixed in `24451c7`)

At `b77c43e`, `PaidWhenRemoved` was violated because `MagicSkipsMember` was FALSE. The steps:

1. A player in the arena, during a battle, casts real-time magic, such as right clicking a wand off turn.
2. Its projectile (`projectile/move` → `magic/hit`) or aoe (`magic/aoe/apply`) kills a `battle_member` enemy.
3. `damage/kill` tags it `battle_reward_pending` and `kill`.
4. In that tick no `battle/turn_end` runs, so `proc_all` never pays it.
5. The `reward/field_kill` line skips `battle_member`.
6. `kill @e[tag=kill]` removes it unpaid.

The fix: `magic/.mcfunction` refuses casters with `test.battle.id` ≥ 1 and shows 戦闘中は使えない. Battle magic
goes through the turn's スキル (`skill_cast/`). Equipment procs in a battle go through `equip/proc/cast_battle`,
not `magic/`.

The fix rests on an assumption, listed under Not covered: only battle members are in `test:arena`. If you
remove the gate, the check fails again. This was proven by a scratch edit, which was reverted.

## Not covered

- More than 2 enemies, or more than one battle instance at a time. `proc_all` filters by battle id, and the
  model has one id.
- What `grant_reward` gives, and whether the recipients are right: everyone within 32 blocks for field kills,
  the members for battle kills. Only how often it runs is checked.
- The `dummy` enemy (excluded from field rewards by design). Players dying. Joining mid-battle. Logging out
  (`battle/rejoin`).
- Damage amounts. A hit is either lethal or nothing.
- Players in `test:arena` who are not in a battle (`debug/goto_arena_<n>`, spectators). The cast gate trusts
  that only battle members stand next to battle enemies. Such a player's magic could still kill one unpaid.
