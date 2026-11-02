# Data pack verification map

This directory is the maintained list of user-facing behavior to verify in game. Read this index, then
use the matching feature file as the recipe. `MC` is the helper defined in [../SKILL.md](../SKILL.md).

## Baseline preconditions

- Minecraft 26.3 runs the world `test` in creative mode.
- The Minecraft window is in front and the user is away from the PC.
- `MC -Doctor` shows `foreground: True` and `errors since last reload: 0` after `MC -Cmd "/reload"`.
- The player is in `test:action` (`/function test:debug/goto_action`), flying (see SKILL.md, Positioning).
- A harmless hotbar slot is selected, such as the stone block. Never select the factory key or the scanner
  before a right click.
- The temporary NPCs are at y=0, z=-15:

  | NPC | x | role |
  | --- | --- | --- |
  | elder 村長 | 0 | talk |
  | herbalist 薬師 | 3 | talk |
  | shopkeeper 道具屋 | -3 | shop `general` |
  | banker 銀行員 | -6 | bank |

  Stand at z=-12.5 facing yaw 180 in front of one.

## Driving conventions

- Start each recipe from the baseline. Set quest, flag and money preconditions with the debug functions:
  - `test:debug/quest_op {id:"<q>",op:"reset|start|advance|complete"}`
  - `test:debug/money_add` (+100 G to the bank)
  - `test:item/material/give {id:"<m>",count:<n>}`
- Commands are literal. Escape inner quotes for Bash: `MC -Cmd "/function test:debug/quest_op {id:\"herb\",op:\"reset\"}"`.
- Take a shot before every click whose position you have not measured in this run.

## Proof and skip reporting

- Bracket each journey with `MC -Mark` and `MC -Since <n> -Save "$TEMP/mc-verify/<run>/<feature>.txt"`.
- Prove a state change with a second read-only view: `/trigger test.quest`, `/function test:debug/flags`,
  or `/clear @s <pred> 0`.
- Name the feature ID and every debug shortcut you used in the report.
- A journey you could not drive is reported as not verified, with the reason. Don't report it as verified
  through another path.

## Feature entry contract

Each feature file has an H1, one paragraph, and the H2s `Sub-features`, `How to get to it (user POV)`,
`Driving it with mc.ps1` (starting with `Preconditions:`) and `Gotchas`.

## Features

- [Pack loads](./pack-load.md): `/reload` with no function or registry errors.
- [NPC dialogue](./npc-dialogue.md): right click an NPC, follow choices, old buttons are ignored, leaving ends the talk.
- [Quests](./quests.md): accept, the reach, kill, deliver and talk stages, rewards, the quest list.
- [Shop and bank](./shop-bank.md): the gaze cart, buying, selling, depositing and withdrawing coins, sneaking to talk.
- [Kill rewards](./kill-rewards.md): real-time and turn-based kills pay drops and quest progress exactly once.
