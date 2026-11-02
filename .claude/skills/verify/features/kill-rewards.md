# Kill rewards

Killing an enemy pays everyone eligible once. The pay covers material drops, equipment drops, exp and job
exp, plus quest kill progress. This happens in real time (`test:action`) and in turn-based battle, which
starts when a field enemy in `test:turn` touches the player.

## Sub-features

- `kill-field` a real-time kill pays everyone within 32 blocks once (`reward/field_kill`).
- `kill-battle` a turn-based kill pays the battle's members at the end of that turn (`battle/proc_all`).
- `kill-once` a battle kill is not paid again after the battle ends.
- `kill-quest` the kill counts toward an active `kill` quest stage.

## How to get to it (user POV)

- In `test:action`, hit an enemy with a weapon.
- In `test:turn`, let a goblin touch you, then choose 攻撃 on your turn.

## Driving it with mc.ps1

Preconditions:

- The baseline is met. The `#debug` sidebar is on, so `[DEBUG] ドロップ:` lines are logged. The quest
  `herb` is active at stage 1: run `quest_op reset` then `quest_op start`. Hotbar slot 4 holds a sword.

- **Field kill.** Run these commands:
  - `MC -Cmd "/execute positioned 11.5 -59 0.5 run function test:asset/enemy/spawn {id:\"goblin\"}"`
  - `MC -Cmd "/tp @s 9.5 -59 0.5 facing 11.5 -58.6 0.5"`
  - `MC -Keys "4"`
  - `MC -Click <center>`

  The log shows `ゴブリン に…ダメージ！` and exactly one `[DEBUG] ドロップ:` line. Then `/trigger test.quest`
  shows `ゴブリンを倒す 1/3`.
- **Battle kill.** Run `MC -Cmd "/function test:debug/goto_turn"` and `MC -Cmd "/function test:debug/spawn_goblin"`.
  Wait until the log shows `あなたの番です`. Then run
  `MC -Cmd "/scoreboard players set @s test.battle.chat_select 1"`. The log shows `ゴブリンを倒した！`,
  `戦闘に勝利した！`, and exactly one `[DEBUG] ドロップ:` line for that enemy. The quest count rose by 1.
- **Proof.** Run `MC -Since $N -Save "$TEMP/mc-verify/<run>/kill-rewards.txt"`, then count the `ドロップ` lines
  with `grep -c`.

## Gotchas

- Goblins sink in the ocean maps. Spawn them on the floor (y=-59) and fight there.
- Two `ドロップ` lines for one battle kill means the reward was paid twice. This happened before the
  `battle_killed` tag existed. Treat it as a regression, not as noise.
- The turn-based action items go to the inventory and are unreachable when the hotbar is full. Use the
  `chat_select` score, which is the same entry point as the chat UI.
- Win or lose, the battle returns you to `test:turn`. Run `test:debug/goto_action` before the next recipe.
