# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A Minecraft Java Edition data pack (namespace `test`) implementing a turn-based/real-time RPG battle
system (stats, buffs/debuffs, magic crafting, weapons, enemy AI) entirely in `.mcfunction` + JSON. There
is no compiler, linter, or test runner — every `.mcfunction` file is loaded verbatim by the game.

**The folder path says `1.20.5` but the actual game version in use is 26.3** (`pack.mcmeta` is
format 121, written as bare integers in `min_format`/`max_format`). Do not assume 1.20.5-era
syntax/mechanics; when unsure, check how an existing, working file in this pack already does something
rather than relying on general Minecraft knowledge. For vanilla schemas, the authoritative source is the
installed client jar (`.minecraft/versions/<version>/<version>.jar`): read its bundled
`data/minecraft/...` JSON, or the class files' strings for codec field names — web/wiki summaries were
wrong or contradictory several times during the 26.3 migration. `MIGRATION-26.3.md` records what
actually changed in 26.3 and how this pack followed; it lives outside `data/` so the game ignores it.

A third-party library is bundled under another namespace and should not be edited: `data/oh_my_dat`
(per-player/per-entity storage library, loaded via `test:load` → `oh_my_dat:sys/load`). Trig and
other float math is done with the vanilla `compute` command against providers registered under
`data/test/context_float_provider/` (syntax: `compute <context> float <provider-id> <scale>` returns
floor(value × scale); `sin`/`cos`/`from_int` take `input`, `mul`/`add` take `inputs`, `div` takes
`left`/`right`, and a provider can reference another registered one by its id string).

## "Build / lint / test"

There isn't any — verification is manual, in-game:

- `/reload` after editing any file to reload the data pack.
- `/function test:debug/spawn_enemy` or `test:debug/spawn_goblin` (see `data/test/function/debug/`)
  to summon test enemies; `test:debug/goto_turn` / `goto_action` / `goto_arena_<n>` to jump between
  the pack's dimensions.
- `/function test:debug/menu` opens a clickable chat menu for all debug tooling:
  - sidebar on/off (`test:debug/on`/`off`, `#debug test.debug.enabled`)
  - built-in logs that can be switched on: damage calculation (`#log_damage`) and battle flow
    (`#log_battle`), both on `test.debug.enabled`; the output lives in `debug/trace/`
  - fixing or replaying each random roll
  - showing the full state of yourself or the nearest entity (`debug/inspect/`)
  - watching arbitrary scores in the sidebar (`debug/watch/`)
- When hunting a bug, reach for these before writing temporary `tellraw` lines. If a value isn't covered,
  prefer adding a permanent, switchable log under `debug/trace/<category>/` (gated at the call site by
  `execute if score #log_<category> test.debug.enabled matches 1 run function ...`) over a throwaway one.
  `function test:debug/log {msg:"..."}` still prints a plain `[DEBUG]` line while `#debug` is on.
- **All randomness goes through `test:rng/roll {key, min, max}`**, never a bare `random value`.
  - It returns the roll as the function result, so call it as
    `execute store result <target> run function test:rng/roll {...}`.
  - It honors per-key overrides in `storage test: debug.rng.<key>` (`mode`: `min`/`max`/`value`).
  - Otherwise it draws from the named sequence `test:<key>`, so `random reset test:<key> <seed>` replays it.
  - Every key must be declared in `init/asset/debug/rng.mcfunction` (the menu lists rolls from there).
    Mark it `fixable:0b` if a fixed result could loop forever (e.g. re-roll-on-duplicate loops).
- Game chat/log output for this specific instance is **not** in the top-level `.minecraft/logs/` —
  this launcher setup keeps a separate log dir per version at
  `.minecraft/versions/1.20.5/logs/latest.log` (and `.../saves/<world>/...` for world data). Check
  that path, not the top-level one, when asked to read what happened in-game.
- There's no automated equivalent of unit tests; when a fix is non-obvious, ask for the actual
  in-game/log result rather than guessing twice. Have the user turn on the relevant debug log or watch,
  or fix/replay the roll involved; add debug output only when those don't cover it.
- A malformed registry JSON (predicate, loot table, enchantment, advancement, item_modifier, provider)
  stops the world from loading at all; `latest.log` names the exact file and key under
  `Registry loading errors`. A `.mcfunction` parse error doesn't block loading but shows up as
  `Failed to load function` on `/reload`.

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
  (`(0,100,0)`, `(500,100,0)`, `(1000,100,0)`, `(1500,100,0)`), each tracked by a `battle_marker` entity that
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
- **Weapons / armor / accessories share one item data shape** in `custom_data`:
  - Keys: `status_bonus` (main stat), `substatus[]` (`{type, value, grow}`), `level`/`max_level`, and
    `{type, value}` entries whose `type` is `<stat>_add` / `<stat>_m` or `<element>_resist_add`.
  - Weapons additionally carry `base_status`, `weapon[]`, `damage`, and `test.*` flags.
  - Armor/accessories carry `equip:{slot, set?}` and deliberately have **no `base_status`**.
  - Stat type names must match the `test.status.<stat>` names (`hp_max_*`, not `max_hp_*`), because
    `status/update` builds `$(status)_add`/`_m` from them. A mismatch silently never applies; this happened
    with HP substats.
  - `init/set_table` holds the substat roll table, per-level `grow`, and lore `stat_display`. The roll table
    is indexed by roll value, so only append to its end. Weapons roll 0..9 and armor rolls 0..15 (adds
    resistances), chosen via `storage test: loot.substatus_max` and `test:loot/roll_substatus_type`.
  - Item lore is never edited line by line: `test:item/weapon/lore/render` rebuilds the whole lore from
    `custom_data` on creation and on every level-up. Add lore by extending that renderer.
- **Weapon/equipment definitions are generated from a Google Sheet** by `tools/datasheet/generate.ps1`
  (PowerShell 5.1; run `generate.cmd`, or `generate.cmd -Offline` to use `tools/datasheet/data/*.csv`).
  - It covers weapons, forge recipes, armor/accessories, series, 4-piece effects, workshop recipes, runes,
    and consumables.
  - Generated files start with a `# 自動生成: tools/datasheet/generate.ps1…` header. **Never edit them by
    hand**; the next run overwrites them. Change the sheet/CSV and regenerate instead.
  - Generated files: `init/asset/generated/weapons`, `init/asset/equip/generated/{items,sets}`,
    `craft/weapon/forge/recipe/<material>`, `craft/equip/recipe/<material>`,
    `init/asset/rune/generated/runes`, `init/asset/consumable/generated/consumables`. Stale generated files
    in those folders are deleted.
  - The script validates everything before writing anything:
    - stat types against `loot.table.grow` in `init/set_table` (also rune stats)
    - effect `kind`s against the files in `equip/effect/` (4-piece) and `consumable/effect/` (consumables,
      which also need `consumable/lore/<kind>`), and required `params` against that file's `$(…)` names
    - cross-references (series, recipe ids)
    - consumables: `every` ≥ 1; `heal_hp`/`heal_mp` take `percent`/`flat` as non-negative integers (a
      missing one is filled with 0), at least one of them ≥ 1

    So adding a stat type or an effect kind needs no script change. Each tab needs its gid in the
    gitignored `tools/datasheet/config.json` for online runs. Columns are documented in
    `tools/datasheet/README.md`; `tools/` is outside `data/`, so the game ignores it.
  - Weapons are declared at `asset.<id>` and built by `test:asset/weapon/sword/apply {material:<id>}`
    (used for wands too).
- **Equipment (armor/accessories)**:
  - Items live at `asset.equip.items.<id>` (generated, see above) and are built by
    `test:asset/equip/apply {id}` (rarity from `storage test: loot.rare`). They are crafted at the
    `craft/equip/` workshop: slot 9 material, slot 10 reusable pattern. The generated
    `recipe/<material>` maps `loot.equip_part` to an id. Enemies can also drop them via
    `data.equip_drops:[{id, chance}]` (`equip/drop/`).
  - Stats are **aggregated, not read at use time**. `test:equip/recalc` runs from `cache/update` on every
    inventory change. It sums the 4 armor slots, up to `asset.equip.accessory_limit` accessories anywhere
    in the inventory, and 2-piece set bonuses into `test.equip.<type>` (×100). `status/update` just adds
    those, and resistances are written straight into `test.<element>_resist`. A new stat type needs its
    `test.equip.<type>` objective (and a reset line in `equip/reset`).
  - 4-piece set effects are declared per series as `{event, kind, params, desc}`. They are generated into
    `init/asset/equip/generated/sets` from the sheet's 4部位効果 tab. `test:equip/event {event}` is fired at fixed hook points:
    - `magic_cast`: in `magic/` and turn-based `skill_cast/prepare_damage`
    - `attack_hit`: in `attack/hit_buff` and `battle/action/attack_hit_buff`; the target is tagged
      `equip_event_target`
    - `damaged`: at the end of `damage/`

    It dispatches matching effects to `equip/effect/<kind>` with `params` as macro args. Add a behavior
    by writing one effect file and adding a sheet row. Add a new trigger by firing `equip/event` from that hook
    point; it is gated by `test.equip.has_effects` so it costs nothing for players without a 4-piece set.
- **Equipment slots (自動発動の枠)**: armor and accessories get 1/2/3 slots at rarity 3/4/5
  (`asset/equip/apply` → `proc_roll_loop`). Each slot's `event` is rolled from `asset.equip.proc_events`
  (rng key `equip_proc_event`) and is kept even when the content changes. A slot holds exactly one of three
  kinds, set at the 付与台 station (`craft/equip_magic/`: slot 9 the equipment, slots 10–12 → slots 1–3):
  ```
  equip.procs: [
    {event},                                          // empty
    {event, kind:"magic", magic:{…}, name:[…]},       // casts on the event, pays MP like a normal cast
    {event, kind:"item",  item:"<consumable id>", name:[…]},  // uses 1 consumable every `every` events
    {event, kind:"rune",  rune:"<rune id>", name:[…], status:[{type,value}…]}  // always-on stats
  ]
  ```
  - A slot with no `kind` but a `magic` is a magic slot (items made before `kind` existed).
  - Inserting rebuilds the slot as `{event, kind}` first (`slot_reset`), so leftovers never mix. Magic
    and runes are consumed; consumables stay in the station (the slot only names which one to use).
    An overwritten rune is rebuilt from the current `asset.rune.<id>` and returned **after** the
    equipment is given (`return_loop`), because `loot/give` reuses `loot.item`.
  - Runes: `asset.rune.<id> = {item, name, status}`, item marked `custom_data.test.rune`, built by
    `item/rune/build {id}`. The status is copied into the slot at insert time (later definition changes
    don't alter existing gear) and summed in `equip/add_item` through the substatus `entry_queue`.
  - Consumables: `asset.consumable.<id> = {item, name, every, effect:{kind, params}}`, item marked
    `custom_data.test.consumable`, built by `item/consumable/build {id}`. `test:consumable/use {id}`
    (@s = user) runs `consumable/effect/<kind>` with `params` and is independent of slots, so a future
    turn-based item action can call it. All strengths live in `params`, never in the effect function.
    HP/MP healing goes through `consumable/heal {stat, percent, flat}` (max × percent ÷ 100 + flat × 100;
    `flat` uses the lore's units, the scores are ×100), clamped to the max.
  - Magic and item slots are collected by `equip/add_item` → `equip/proc/collect_loop` into
    `test.equip.procs` (oh_my_dat), each tagged with a `key` `"<part>_<index>"` (`head_0`, `acc1_2`, …).
    Rune and empty slots are not collected. `test.equip.has_procs` gates `equip/event`.
  - Events only **queue** (tags `equip_proc.<event>` + `equip_proc_queued` via `equip/proc/queue`), never
    act mid-damage; `tick` runs `equip/proc/run` once per tick, which dispatches by kind in `run_entry`
    (`cast` / `use_item`). So an AoE hitting many targets counts once. Casts from a slot don't re-queue
    `magic_cast` (`equip_proc_casting` tag). Nothing fires in `test:arena`.
  - Item slots count executed queues per slot in `test.equip.proc_count.<key>` (oh_my_dat, outside the
    list that `recalc` rebuilds, so picking up/using items doesn't reset it). At `every` the count resets
    and `use_item` runs `clear … 1` first; only a successful clear runs the effect.
  - `hp_low` fires once when HP drops below `asset.equip.hp_low_percent` % of max (HP×100 vs max×percent),
    checked every tick by `equip/proc/hp_low_check` for players with `test.equip.has_hp_low` (set by
    `recalc` when an hp_low slot has content). The tag `equip_hp_low` blocks repeats until HP is back at
    or above the line. A new event needs a line in `proc_events` and a tag-removal line in `proc/run`.

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

## JSON schemas in this game version (26.3)

- Predicates/loot conditions use **`"type"`** as their dispatch key, not `"condition"` — for predicate
  files, enchantment `requirements`, `all_of`/`any_of` `terms`, and advancement conditions alike. The
  field that *holds* a predicate (e.g. `requirements`, a loot pool's `condition`) keeps its own name.
- Loot functions also use `"type"`, and an entry's function list is **`"modifier"`** (singular name,
  list value), not `"functions"`. An `item_modifier` file must be a single object, not an array.
- Advancement `conditions.player` / `conditions.item` are single objects, not one-element arrays.
- Inline number providers must state their `type` (e.g. `rolls: {type:"minecraft:uniform",…}`); the
  `score` provider is int-only and has no `scale` (lift with `from_int`, multiply with `mul`).
- `value_check` became `int_value_check`/`float_value_check`, with the range under `test`.

## UI conventions specific to this game version

- **Player NBT can be read with `/data get` but never written with `/data modify`/`data remove`.**
  To change a player's items, build the item in the overworld shulker box at `0 -64 0` and either
  `loot spawn` it and let the player pick it up (`test:loot/give`, `test:job/bundle/deliver`) or
  `item replace entity @s <slot> from block 0 -64 0 container.0`; remove items with `clear`. Items on
  the cursor aren't in the player NBT at all — copy them to the shulker box with
  `item replace block 0 -64 0 container.0 from entity @s player.cursor` to read them.
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
