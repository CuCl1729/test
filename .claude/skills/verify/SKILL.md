---
name: verify
description: Drive the running Minecraft 26.3 client to prove a change to this data pack (namespace test) works in game - reload, run commands, talk to NPCs, click chat buttons and GUIs, fight, and read the chat log as evidence. Use after editing any .mcfunction/JSON or generator output, when asked to "test it in game", or to reproduce an in-game bug. Windows only; needs agent-desktop and the user's open world.
---

# Verify in game

The app is the user's own Minecraft 26.3 client with the world `test` open. This pack is loaded from
`saves/test/datapacks/test`, and there is one instance only: the user's, on the user's desktop. You
drive it with keystrokes and mouse clicks and read what happened from the game log.

All driving goes through one helper. Run it from the repo root:

```bash
MC() { powershell -NoProfile -ExecutionPolicy Bypass -File .claude/skills/verify/scripts/mc.ps1 "$@"; }
export MSYS_NO_PATHCONV=1   # Git Bash would rewrite "/reload" into a Windows path
```

Every input command first checks that Minecraft is the foreground window. If it is not, the command sends
nothing, prints `NOT_FOREGROUND` and exits 2. Treat that as "the user is using the PC": stop and ask the
user to bring Minecraft to the front and step away. Never focus the window yourself, and never retry in a
loop.

## Launch

You cannot launch Minecraft yourself, because it needs the launcher and the user's account. Ask the user
to do these steps:

1. Start Minecraft 26.3.
2. Open the world `test` in creative mode.
3. Leave the window in front and take their hands off the PC.

Ready means all of these are true:

- `MC -Doctor` prints `window: w-…` and `foreground: True`.
- `MC -Cmd "/reload"` runs.
- `MC -Doctor` then prints `last load/reload` at a newer line and `errors since last reload: 0`.

A `.mcfunction` parse error shows up as a `Failed to load function` line in the log. A bad registry JSON
stops the world from loading at all.

There is no teardown of the client: never close the game or the world.

## Doctor

`MC -Doctor` is read-only. It prints the following:

- the Minecraft window id and bounds, or `NONE`
- whether Minecraft is in front
- the log line count and last write time
- the line of the last world start or `/reload`
- the `Failed to load function` / `Registry loading errors` lines since then
- the last login line

Run it first, and again whenever input seems to do nothing.

## Drive

| Action | Command |
| --- | --- |
| Run a command | `MC -Cmd "/function test:debug/menu"` (opens chat with `t`, types, presses Enter; the chat must be closed first) |
| Raw keys | `MC -Keys "{ESC}"`, `MC -Keys "4"` (hotbar slot), SendKeys syntax |
| Literal text into an open chat | `MC -Text "..."` |
| Fly | `MC -Fly` (double Space; creative only) |
| Sneak | `MC -Sneak 1500` (holds left Shift; while flying this descends instead) |
| Screenshot | `MC -Shot "$TEMP/mc-verify/<run>/shot.png"`, then Read the image |
| Click | `MC -Click 120,340` or `MC -Click 120,340 -Right` (pixel coordinates in the LAST screenshot) |
| Look at a spot | `MC -Cmd "/tp @s <x> <y> <z> facing <x> <y> <z>"`, then `MC -Click` at the screen center for the crosshair |

How to drive it:

- **Positioning.** Teleport, don't walk. `test:action` and `test:turn` are flat oceans with water from y=-59 to
  y=-1, and a player who stops flying sinks. Teleport to y=20 first, run `MC -Fly`, then teleport where you
  need to be. Flying survives later teleports. Look with `facing` and click the center.
- **Chat buttons** (dialogue, debug menu, `test.talk` choices). Open the chat with `MC -Keys "t"`, take a shot,
  find the button text, and run `MC -Click x,y`. The chat stays open after a click. The newest line is just
  above the input bar, and lines are about 18 px apart. When a click has no visible effect, read the log
  instead of clicking again.
- **Container GUIs** (stations, shop and bank carts). A right click on the target opens the GUI. In a shot,
  slot n of a 27-slot container sits at `(285 + 36*(n%9), 156 + 36*floor(n/9))` in a 856x512 window. Take a
  shot to confirm, because the window size changes these numbers.
- **Turn-based battle.** The action items go to the inventory, and with a full hotbar you can't reach them.
  The chat UI uses the same score: `MC -Cmd "/scoreboard players set @s test.battle.chat_select 1"` attacks
  (2 skill, 3 item, 4 defend, 5 flee).
- **Debug tools.** Use the pack's own debug functions instead of hand-made setups. The full list is in
  [features/README.md](features/README.md). The main ones:
  - `test:debug/quest_op {id,op}`
  - `test:debug/flags`
  - `test:debug/money_add`
  - `test:item/material/give {id,count}`
  - `test:debug/spawn_goblin`
  - `test:debug/goto_turn`

## Evidence

The proof is the game log, not a screenshot.

1. Before acting, run `N=$(MC -Mark | tr -d '\r')`.
2. After acting, run `MC -Since $N -Save "$TEMP/mc-verify/<run>/<feature>.txt"`. It prints and saves only the
   `[CHAT]` lines, which hold command feedback, `tellraw` output, and the damage, battle and debug logs.

Proof standards:

- Drive the user path: right click the NPC, click the chat button, take the item from the GUI. Don't call
  the internal function that the button would run. Use debug functions only to set up preconditions, such
  as giving items, starting a quest or skipping a stage, and say so in the report.
- Prove side effects with a second, read-only view:
  - quests: `/trigger test.quest`
  - flags: `/function test:debug/flags`
  - items: `/clear @s <predicate> 0`, which counts without removing
  - entities: `/execute if entity @e[tag=...]`
- Action-bar text never reaches the log. When the action bar is part of the claim, take a shot within about
  1 s, before chat lines from the same moment cover it.
- Screenshots may contain personal information. They live only in `$TEMP/mc-verify/<run>/`, never in the
  repo, and you delete them as soon as you have read them. The saved chat logs are the lasting proof.

## Cleanup

There are no processes to kill. Cleanup means undoing what the run changed in the user's world:

- Revert blocks you placed, for example `setblock … minecraft:water`.
- Remove scoreboards and entities you added.
- Restore attributes, such as `/attribute @s minecraft:gravity base reset`.
- Tell the user about leftover quest or flag state, and offer the debug reset (`test:debug/quest_op
  {id,op:"reset"}`).
- Run `MC -Keys "{ESC}"` only while the chat or a GUI is open. On the plain game view it opens the pause menu.
- Delete the screenshots: `rm -f "$TEMP"/mc-verify/<run>/*.png`.
- Keep the `.txt` chat logs. They are the evidence, and they live outside the repo.

## Gotchas

- Sends are slow, about 0.6 s per PowerShell start. Chain related steps in one Bash call.
- A stray number key changes the held item, and right-clicking with the factory key teleports you into the
  factory. Before right-clicking an NPC, select a harmless hotbar slot, such as the stone block.
- Pressing Enter on a chat command closes the chat. Clicking a chat button does not.
- The MP display owns the action bar every tick, unless a message was sent with
  `execute store success score @s test.ui.bar_shown run title @s actionbar …` (see CLAUDE.md).
- If the user is using the PC, stop and wait. That includes anything you notice in the shots or a sudden
  `NOT_FOREGROUND`.
- Aim with an explicit rotation, `/tp @s <x> <y> <z> <yaw> <pitch>`. Then check the shot that the crosshair is
  on the target. A `facing` point aimed at a block can land on a marker armor stand in front of it.
- In the arena, the camera starts inside the enemy's model, so a right click hits the enemy, not your item.
  Before you use an item, run `/tp @s ~ ~ ~-3 0 -90` (step back and look up).
- The player's armor casts its own magic when an enemy hits (`防具の魔法！`), so MP drops every enemy turn.
  Read MP right before and right after your action, and attribute a change to your action only if the log
  shows no proc in between.
- Fleeing next to a field AI goblin starts a new battle at once. To end a test battle, win it
  (`chat_select 1`).
- A magic item (nether star, `custom_data.test.magic`) can only be made at the 魔法台:
  1. `execute positioned <x> <y> <z> run function test:debug/spawn_station {id:"magic"}`.
  2. Open the station.
  3. Click slot 2 (投射), then slot 26 (作成).
  4. The item drops on top of the barrel. Teleport onto it to pick it up.

  Afterwards, remove the station with `kill @e[tag=station,distance=..1]` at its center, then `setblock … air`.
  Do both from inside that map, because the station's chunk must be loaded.
