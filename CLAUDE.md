# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A Minecraft Java Edition data pack (namespace `test`) implementing a turn-based/real-time RPG battle
system (stats, buffs/debuffs, magic crafting, weapons, enemy AI) entirely in `.mcfunction` + JSON. There
is no compiler, linter, or test runner — every `.mcfunction` file is loaded verbatim by the game.

**The folder path says `1.20.5` but the actual game version in use is 26.2** (`pack.mcmeta` is
`pack_format: 94`). Do not assume 1.20.5-era syntax/mechanics; when unsure, check how an existing,
working file in this pack already does something rather than relying on general Minecraft knowledge.
`MIGRATION-26.3.md` tracks known upcoming breaking changes for the *next* version (number providers,
`value_check` split, etc.) — it's a research note for future work, not something to act on now; it
lives outside `data/` so the game ignores it.

Third-party libraries are bundled under other namespaces and should not be edited: `data/math`
(AiMath, MIT-licensed, used only for `#math:tan`) and `data/oh_my_dat` (per-player/per-entity storage
library, loaded via `test:load` → `oh_my_dat:sys/load`).

## "Build / lint / test"

There isn't any — verification is manual, in-game:

- `/reload` after editing any file to reload the data pack.
- `/function test:debug/spawn_enemy` or `test:debug/spawn_goblin` (see `data/test/function/debug/`)
  to summon test enemies; `test:debug/goto_turn` / `goto_action` / `goto_arena_<n>` to jump between
  the pack's dimensions.
- `test:debug/on` / `test:debug/off` toggle `#debug test.debug.enabled`; code calls
  `function test:debug/log {msg:"..."}` to print a `[DEBUG]` tellraw only while that's on. For ad-hoc
  tracing of scoreboard/storage values during a bug hunt, temporary `tellraw` lines with
  `{"score":{...}}` / `{"nbt":"...","storage":"test:"}` components are the established pattern —
  remove them once the root cause is found.
- Game chat/log output for this specific instance is **not** in the top-level `.minecraft/logs/` —
  this launcher setup keeps a separate log dir per version at
  `.minecraft/versions/1.20.5/logs/latest.log` (and `.../saves/<world>/...` for world data). Check
  that path, not the top-level one, when asked to read what happened in-game.
- There's no automated equivalent of unit tests; when a fix is non-obvious, prefer adding temporary
  debug output and asking for the actual in-game/log result over guessing twice.

## Entry points and per-tick flow

- `data/minecraft/tags/function/{load,tick}.json` point to `test:load` / `test:tick`.
- `test:load` → `test:init/` (forceloads arena chunks, ensures singleton helper entities exist,
  wipes and rebuilds the `class`/`asset` storage roots, then `init/scoreboard` → `init/class` →
  `init/asset/` → `init/set_table`) → `oh_my_dat:sys/load`.
- `test:tick` is a flat dispatcher: one line per subsystem, each gated by a tag/dimension/condition
  check (e.g. `execute as @e[tag=enemy] ... run function test:status/hp_display_tick`). When adding a
  new per-tick subsystem, add one gated line here rather than hooking into another subsystem's file.
- A separate 1-second clock lives inside `tick.mcfunction` (`#clock test.time`) and drives
  `test:buff/tick_second_all` — buff/debuff durations are tracked in seconds, not ticks.

## Dimensions

Three custom flat dimensions under `data/test/dimension/`, each a distinct game area:

- `test:turn` — the explorable field map. Enemies with `data.ai_field_enabled` wander/chase here
  (`battle/field_ai/`) and trigger `test:battle/start` on contact.
- `test:arena` — void dimension holding up to 4 battle instances at fixed offsets
  (`(0,0,0)`, `(500,0,0)`, `(1000,0,0)`, `(1500,0,0)`), each tracked by a `battle_marker` entity that
  owns that instance's turn order/state. `test:battle/setup` claims a free slot and builds the arena;
  `battle/tick` → `turn_start_actor`/`turn_start_enemy` → the acting side's action → `turn_end` is the
  per-battle loop.
- `test:action` — the other player-controlled real-time area (weapon/skill use outside turn-based
  battle).

## The core idiom: declarations + a generic driver

The pack's main extensibility pattern, used consistently across very different subsystems: a leaf file
under `asset/` (or an `init/asset/*` registry) *declares data only*, and separate generic code reads
that data to decide what to do. Adding a new instance of something almost never means touching the
generic driver — it means adding a declaration plus a small per-id handler function.

- **Enemies**: `asset/enemy/<name>/.mcfunction` builds a full stat block into the `enemy.*` storage
  root (see `asset/enemy/dummy/.mcfunction` for the baseline reference stats) plus optional
  `enemy.data.*` flags — `buff_on_hit`, `loot_table`, `ai_field_enabled`, `ai` (weighted
  attack/defend/gimmick behavior read by `battle/enemy_ai/decide.mcfunction`) — then
  `asset/enemy/summon.mcfunction` copies `enemy.data` onto the summoned entity's `data` tag verbatim.
  `dummy` is intentionally kept static (a balance-testing mannequin, no `ai`/`ai_field_enabled`); new
  behaviors go on new enemies like `goblin`, not on `dummy`.
- **AI gimmicks**: a per-enemy `data.ai.gimmicks` entry (`{id, weight, hp_below?, cooldown?}`) is
  matched to `battle/enemy_ai/gimmick/<id>.mcfunction`. Extending an enemy's move set is: declare an
  entry, write that one function (it must end by calling `battle/action/attack`, `.../defend`, or
  `battle/turn_end` directly).
  Actions are weighted-random over attack (fixed) + defend (0 unless an enemy explicitly declares
  `data.ai.defend_weight` — enemies deliberately default to *not* defending, since HP-scaled defend
  weight was found to make fights drag on) + eligible gimmicks.
- **Buffs/debuffs**: registered once in `init/asset/buff/buffs.mcfunction` (id, duration, stacking,
  which of `apply`/`expire`/`interval` events it needs); the actual effect is
  `buff/on/{apply,expire,interval}/<id>.mcfunction`, almost always via `buff/stat/add`/`buff/stat/remove`
  (`{stat, amount}`) rather than touching scores directly. `status/recalc.mcfunction` reconciles the
  accumulated buff amount into the effective `test.status.<stat>`: players get fully rebuilt from
  equipment via `status/update` (except mid-battle turn-UI, where the main hand is a UI item, not the
  real weapon — there it patches the score directly instead, matching `damage/pre_magic`'s handling of
  the same situation); non-players (no equipment) just add onto the `test.status.base.<stat>` recorded
  at summon time.
- **Magic**: `init/asset/magic/{types,effects}.mcfunction` register the catalog; `asset/magic/type/<t>`
  and `asset/magic/effect/<e>` hold the per-id logic. When one effect's `data modify ... set value`
  targets a compound another effect also writes to, use `merge value`, not `set value` — `set`
  silently destroys sibling keys other effects already wrote (this was a real bug: an atk-boost effect
  overwriting a fire effect's sibling key in the same compound).

## Battle/combat pipeline

`attack/` and `scan/` build the list of hit targets (`scan/{circle,cone,cylinder,ray_cast}` +
`scan/hit.mcfunction`), `attack/hit_apply.mcfunction`/`hit_buff.mcfunction` apply on-hit buffs, and
`damage/.mcfunction` computes and applies the actual number per element type. The defense step there
follows two deliberate design invariants (see the comments in that file for the derivation): raising a
defender's raw `test.status.def` must always reduce the multiplier (never accidentally increase it —
this direction broke once when the `guard` buff was special-cased around an earlier, wrong formula), and
stacking attacker `def.pene` / defender `def.debuff` gives *accelerating* (not diminishing) returns per
point, with `def.coefficient` acting purely as the defender's resistance to that pene/debuff (and having
no effect at all when pene/debuff is zero).

## UI conventions specific to this game version

- **Text/name fields are raw NBT compounds, not JSON strings.** `custom_name`/`CustomName` and similar
  take `{text:"...",color:"..."}` (or a list of such compounds) directly — never a quoted
  `'{"text":"..."}'` string. Wrapping a text component in a string produces literal, unparsed text
  in-game; this bit both an item name and an entity `CustomName` in this pack already.
- **Barrel-based GUIs** (`magic/crafter/`, `craft/magic/research/`, and the minecart-based battle menus
  under `battle/ui/`) detect clicks with `execute unless data block ~ ~ ~ Items[{Slot:Nb}] ...` — the
  `data` keyword is mandatory; omitting it parses as an unrelated block-predicate form and fails
  silently. Shift-click vs. normal-click is told apart with
  `execute if items entity <player> player.cursor <item_predicate>` (index 499, the "item on cursor"
  slot) rather than inventory-changed advancements, since the latter never fires when the player's
  inventory is full. Every placed UI item carries a `custom_data` marker so it can be blanket-cleared
  from the player's hand/cursor at the end of each click handler.

## Scoreboard/storage conventions

- All numeric game state lives in scoreboards (integers only); NBT storage is used for structured
  data (registries, per-action work buffers) but never for anything that needs arithmetic.
- Constants used in `scoreboard players operation` (to avoid magic numbers and repeated `set`s) live
  on the `#<n> test.constant` fake players, initialized once in `init/set_constant.mcfunction`.
- Several stats are stored as fixed-point integers scaled per-stat (e.g. crit rate as parts-per-10000);
  the scale is a per-stat convention established by each stat's own code, not a single pack-wide rule —
  check how a stat is already read/written elsewhere before assuming its scale.
- `test.<domain>.work` / `test.temporary` / `test.buff.work` objectives are scratch space reused across
  many functions for intermediate values (loop counters, per-call temporaries) — not persistent state.
