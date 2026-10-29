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
  - ルートテーブルは抽選に使わない(条件で決まるものだけに使う)。抽選は関数で `test:rng/roll` を通す。
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

- **Enemies** are declared in the sheet's 敵 / 敵のギミック / 敵のドロップ tabs (generated, see below) as
  `asset.enemy.<id> = {name?, stats:{hp,mp,atk,def,coef,crit_rate,crit_damage,exp}, resist:{…}, data}`.
  `test:asset/enemy/spawn {id}` → `asset/enemy/load` builds the `enemy.*` storage root and the `#enemy`
  scores from it (HP/MP start full; damage bonuses 100, pene/debuff 0 are fixed in `load`), then
  `asset/enemy/summon.mcfunction` copies `enemy.data` onto the summoned entity's `data` tag verbatim.
  `data` carries `buff_on_hit`, `material_drops` (`[{id, min, max}]` from the 敵のドロップ tab; one roll per
  entry, see rewards under "Battle/combat pipeline"), `attack_element` (the
  normal attack's element, from the sheet's 攻撃属性; `battle/action/attack_damage_enemy`), `equip_drops`,
  `ai_field_enabled`, `ai` (weighted attack/defend/gimmick behavior read by
  `battle/enemy_ai/decide.mcfunction`). `dummy` is intentionally kept static (a balance-testing
  mannequin, no `ai`/`ai_field_enabled`); new behaviors go on new enemies like `goblin`, not on `dummy`.
  Spawn any enemy with `test:debug/spawn_enemy_id {id}` (also in the debug menu).
- **AI gimmicks**: a per-enemy `data.ai.gimmicks` entry (`{id, weight, hp_below?, cooldown?, params}`, from
  the sheet's 敵のギミック tab) is matched to `battle/enemy_ai/gimmick/<id>.mcfunction`, which `act_gimmick`
  calls `with` the entry's `params` (the generator requires every `$(…)` of that file). Existing ones:
  `enrage` (buff self + attack), `magic` (element/power/target/label; its own `#damage`, no crit — the
  player magic path needs MP/burnout/effect_damage that enemies don't have), `heal`, `curse` (debuff
  players), `rally` (buff allied enemies). Targeting players goes through `enemy_ai/part/target_{one,all}
  {fn}`; helpers live in `enemy_ai/part/` (not in `gimmick/`, whose files are all treated as gimmicks).
  Extending an enemy's move set is: write that one function (it must end by calling
  `battle/action/attack`, `.../defend`, or `battle/turn_end` directly) and add a sheet row.
  Actions are weighted-random over attack (fixed) + defend (0 unless an enemy explicitly declares
  `data.ai.defend_weight` — enemies deliberately default to *not* defending, since HP-scaled defend
  weight was found to make fights drag on) + eligible gimmicks.
- **Buffs/debuffs**: registered once in `init/asset/buff/buffs.mcfunction` (id, label, icon, kind,
  refresh, which of `apply`/`expire`/`interval` events it needs); `duration`, `max_stacks`, `interval` and
  the effect strength `params` are merged in from the sheet's バフの数値 tab
  (`init/asset/buff/generated/values`). The actual effect is `buff/on/{apply,expire,interval}/<id>.mcfunction`,
  which `buff/fire_entry` calls `with` the buff's `params` (never hard-code amounts there), almost always via `buff/stat/add`/`buff/stat/remove`
  (`{stat, amount}`) rather than touching scores directly. `status/recalc.mcfunction` reconciles the
  accumulated buff amount into the effective `test.status.<stat>`: players get fully rebuilt from
  equipment via `status/update` (except mid-battle turn-UI, where the main hand is a UI item, not the
  real weapon — there it patches the score directly instead, matching `damage/pre_magic`'s handling of
  the same situation); non-players (no equipment) just add onto the `test.status.base.<stat>` recorded
  at summon time.
- **Magic**: `init/asset/magic/{types,effects}.mcfunction` register the catalog; `asset/magic/type/<t>`
  and `asset/magic/{effect,status}/<e>` hold the per-id logic. Each element's `cost` and `params` (speed,
  radius, base damage, max stacks…) come from the sheet's 魔法の数値 tab (merged by
  `init/asset/magic/generated/values`); every build path calls `test:asset/magic/run {id, folder}`, which
  passes them as macro args, so per-id files read `$(cost)`/`$(…)` instead of literals. When one effect's `data modify ... set value`
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
  - The substat roll table, per-level `grow`, and lore `stat_display` come from the sheet's ステータス tab
    (`init/asset/generated/stats`, called by `init/set_table`, which still holds `element_display`). The roll
    table is indexed by roll value: weapon-eligible rows first (0..`loot.table.substatus_weapon_max`), then
    armor-only rows such as resistances (armor rolls 0..`loot.table.substatus_armor_max`), chosen via
    `storage test: loot.substatus_max` and `test:loot/roll_substatus_type`.
  - Item lore is never edited line by line: `test:item/weapon/lore/render` rebuilds the whole lore from
    `custom_data` on creation and on every level-up. Add lore by extending that renderer.
- **Game data is generated from a Google Sheet** by `tools/datasheet/generate.ps1`
  (PowerShell 5.1; run `generate.cmd`, or `generate.cmd -Offline` to use `tools/datasheet/data/*.csv`).
  **Balance numbers belong in the sheet, not in function literals** — when adding a feature with tunable
  values, add them to a tab (or `params`) and read them via macro args/storage.
  - Tabs: stats, materials, weapons, forge recipes, armor/accessories, series, 4-piece effects, workshop
    recipes, runes, consumables, enemies (+ gimmicks, drops), jobs (+ skills), magic values, buff values,
    player base stats, constants, ores, mines, pickaxes. A tab without a gid in `config.json` is not
    downloaded; its local CSV is used.
  - **Units**: status values (enemy HP/atk/def/…, job growth, buff params, player base stats) are written in
    display units (as in item lore) and the script multiplies by 100; resist %, exp, chance %, counts are
    as written; magic `params` are raw (internal) values.
  - Generated files start with a `# 自動生成: tools/datasheet/generate.ps1…` header. **Never edit them by
    hand**; the next run overwrites them. Change the sheet/CSV and regenerate instead.
  - Generated files: `init/asset/generated/{weapons,stats,config}`, `init/asset/equip/generated/{items,sets}`,
    `craft/weapon/forge/recipe/<material>`, `craft/equip/recipe/<material>`,
    `init/asset/{rune,consumable,material,enemy,job,magic,buff,status,ore,mine,pickaxe}/generated/*`. Stale
    generated `.mcfunction` files in those folders are deleted. The only generated loot tables are the mines'
    ore blocks, `data/minecraft/loot_table/blocks/<block>.json` (a fixed single token, no rolls). JSON can't
    carry the header, so **stale ones are not deleted: remove them by hand** when a mine is removed or its
    block changes (the script lists the ones it wrote). Never touch the hand-written `red_shulker_box.json`.
  - Registries that keep their structure hand-written and only get numbers merged in from the sheet:
    `init/asset/magic/{types,effects}` (+ `magic/generated/values`), `init/asset/buff/buffs`
    (+ `buff/generated/values`). Constants are `asset.config.{turn_time,turn_warn,enemy_delay,accessory_limit}`.
    Player base stats are set by `init/asset/status/generated/base` (from `vanilla` on first join, and for
    everyone online on every `/reload`).
  - The script validates everything before writing anything:
    - stat types against the ステータス tab rows that have a `成長` (also rune stats)
    - effect `kind`s against the files in `equip/effect/` (4-piece), `consumable/effect/` (consumables,
      which also need `consumable/lore/<kind>`), `job/skill/handler/` (job skills), gimmick ids against
      `battle/enemy_ai/gimmick/`, and required `params` against that file's `$(…)` names (magic: the
      per-id file; buffs: all `buff/on/*/<id>`)
    - cross-references (series, recipe materials by role, drops, enemy buffs/equip drops, job prerequisites)
    - enemy `攻撃属性` (物理/火/水/木/金/土), gimmick `params` against the gimmick file's `$(…)` (and `buff`,
      `element`, `target` values); consumable `revive` `percent` 1–100
    - mines: ore block unique per mine (and not `red_shulker_box`), ore exists, rank ≥ 1, interval ≥ 0,
      weights (rarity 1–5, weight ≥ 0, total ≥ 1), area 6 / entrance 3 integers, structures `ns:path@x y z`;
      a pickaxe that can mine nothing is an error, a mine no pickaxe can mine is only a warning
      (`Add-Warn`: printed in yellow, generation continues)
    - every magic element, buff, base stat and constant has a row; job `exp_coefficient` ≥ 1 (0 would
      level up forever); gimmick `hp_below` defaults to 100 (a missing value would read as 0)
    - consumables: `every` ≥ 1; `heal_hp`/`heal_mp` take `percent`/`flat` as non-negative integers (a
      missing one is filled with 0), at least one of them ≥ 1

    So adding a stat type, an effect kind or a skill kind needs no script change. Columns are documented in
    `tools/datasheet/README.md`; `tools/` is outside `data/`, so the game ignores it.
  - Materials (`asset.material.<id> = {item, name, role, data}`, roles material/catalyst/special/pattern)
    are built by `test:item/material/build {id}` and handed out by `test:item/material/give {id,count}`
    (straight into the inventory, not through `test:loot/give`, whose `tooltip_display` would stop them
    stacking). Enemy drops and the debug menu both use it, so dropped and given materials stack.
    Special materials' effects are code (`craft/weapon/forge/craft`,
    `asset/weapon/`).
  - Weapons are declared at `asset.<id>` and built by `test:asset/weapon/sword/apply {material:<id>}`
    (used for wands too).
- **Equipment (armor/accessories)**:
  - Items live at `asset.equip.items.<id>` (generated, see above) and are built by
    `test:asset/equip/apply {id}` (rarity from `storage test: loot.rare`). They are crafted in the 工房
    station's 防具 mode (`craft/equip/craft`): slot 9 material, slot 10 reusable pattern. The generated
    `recipe/<material>` maps `loot.equip_part` to an id. Enemies can also drop them via
    `data.equip_drops:[{id, chance}]` (`equip/drop/`).
  - Stats are **aggregated, not read at use time**. `test:equip/recalc` runs from `cache/update` on every
    inventory change. It sums the 4 armor slots, up to `asset.config.accessory_limit` accessories anywhere
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
  kinds, set in the 強化台 station's 付与 mode (`craft/equip_magic/craft`: slot 9 the equipment, slots 10–12
  → slots 1–3):
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
    (@s = user) runs `consumable/effect/<kind>` with `params` and is independent of slots; the turn-based
    item action (`battle/action/item_use`) uses it too. Both callers ask `consumable/can_use {id}` first and
    don't spend the item when it returns 0 (e.g. `revive` with nobody to revive). All strengths live in
    `params`, never in the effect function.
    HP/MP healing goes through `consumable/heal {stat, percent, flat}` (max × percent ÷ 100 + flat × 100;
    `flat` uses the lore's units, the scores are ×100), clamped to the max.
  - Magic and item slots are collected by `equip/add_item` → `equip/proc/collect_loop` into
    `test.equip.procs` (oh_my_dat), each tagged with a `key` `"<part>_<index>"` (`head_0`, `acc1_2`, …).
    Rune and empty slots are not collected. `test.equip.has_procs` gates `equip/event`.
  - Events only **queue** (tags `equip_proc.<event>` + `equip_proc_queued` via `equip/proc/queue`), never
    act mid-damage; `tick` runs `equip/proc/run` once per tick, which dispatches by kind in `run_entry`
    (`cast` / `use_item`). So an AoE hitting many targets counts once. Casts from a slot don't re-queue
    `magic_cast` (`equip_proc_casting` tag).
  - In turn-based battle (`test.battle.id` ≥ 1) `tick` doesn't run the queue; `battle/turn_end` →
    `battle/proc_all` runs it right after each action (before `check_end`, without using a turn), and also
    checks `below` events there. Magic slots go through `equip/proc/cast_battle`, which reuses the turn-based
    magic core (`skill_cast/apply_{projectile,aoe,self}`) with an automatic target: the enemy that was hit
    (`equip_proc_target`, tagged by `queue` from `equip_event_target`) or else the nearest one. Leaving a
    battle clears the queue (`equip/proc/clear_queue` in `return_member*`).
  - Item slots count executed queues per slot in `test.equip.proc_count.<key>` (oh_my_dat, outside the
    list that `recalc` rebuilds, so picking up/using items doesn't reset it). At `every` the count resets
    and `equip/proc/consume` runs `clear … 1` first; only a successful clear runs the effect.
  - Events are declared in `asset.equip.proc_events` (`init/asset/equip/`) as `{id, label, instant?, below?}`.
    **A new event is one line there** (plus firing `equip/proc/queue {event}` from its hook if it isn't a
    `below` event); `proc/run` clears the `equip_proc.<id>` tags by walking the list.
    - `instant:1b`: item slots skip the `every` count and use one consumable on every trigger (for rare
      events like `hp_low`); the lore then omits "(N回ごと)".
    - `below:{stat, max, percent}`: a threshold event, fired once when `test.status.<stat>`×100 drops below
      `test.status.<max>`×percent and re-armed once it's back at or above (`hp_low` is
      `{stat:"hp",max:"hp_max",percent:30}`; an `mp_low` would be one more line). `recalc` →
      `equip/proc/watch_recalc` tags the player `equip_watch.<id>` for each such event that has a filled
      slot and sets `test.equip.has_watch`; `tick` → `equip/proc/watch_check` → `watch_below` compares
      every tick (HP also drops from poison etc., so not inside `damage/`). The tag `equip_below.<id>`
      blocks repeats while below the line.
- **Mining** (pickaxes, mines, ores). Players are in adventure mode, so terrain can't be broken; only the
  mines' ore blocks can, through the pickaxe's `can_break`.
  - Registries (generated from the 原石 / 鉱山 / ツルハシ tabs): `asset.ore.<id> = {item, name}`,
    `asset.mine.<id> = {name, block, ore, rank, weights:[{rare,weight}], weight_total, area:{x1,y1,z1,dx,dy,dz},
    entrance:{x,y,z}, structures:[{id,x,y,z}], interval}`, `asset.pickaxe.<id> = {item, name, rank, speed, blocks}`
    (`blocks` = the ore blocks of every mine whose rank ≤ the pickaxe's, computed by the script), plus
    `asset.{ore,mine,pickaxe}_ids`.
  - Pickaxe: `item/pickaxe/build {id}` sets `custom_data.test.pickaxe {id,rank}`, `can_break {blocks}`,
    `tool {rules:[{blocks,speed,correct_for_drops:true}]}` (needed: vanilla ores drop nothing without the right
    tool tier, whatever the base item is), `unbreakable`, and hides those in `tooltip_display`. Given by
    `item/pickaxe/give {id}`.
  - **Each mine's ore block is used only inside that mine.** The script overwrites that block's loot table
    for the whole map with one token item (`custom_data.test.ore_token:"<mine id>"`, the ore's look and name).
  - Token → ore: `cache/update` runs `mine/token/convert` **before** copying `player_data` (so `equip/recalc`
    sees the result). Per mine id it `clear`s the tokens, rolls each one's rarity (rng key `ore_rarity`,
    1..`weight_total`, walking `weights`), and gives the ores per rarity with `item/ore/give {id,rare,count}`.
    Ores are `custom_data.test.ore = {kind, rare}` only (`item/ore/build`; name color = rarity, 3–5 like
    equipment), so equal ones stack. `item/ore/give` inserts directly (not `loot/give`, whose
    `tooltip_display` breaks stacking) in stacks of 64 and drops what didn't fit at the player's feet:
    `loot give` silently loses overflow, so it compares the count before/after with `clear … 0`.
  - Reset: every second `mine/tick_second` checks each mine in `test:action` and `test:turn` separately
    (`storage test: mine_state.<action|turn>.<id> = {occupied, ready_at}`; `ready_at` is game time in ticks
    from `time query gametime`). When a mine goes from empty to occupied and `ready_at` has passed,
    `mine/reset {id,dim}` places every structure (`place template`), moves players whose feet or head
    block isn't air to the entrance, and sets `ready_at = now + interval × 20`. The arena is never checked.
    `debug/reset_mine` resets the mine you're standing in regardless of the interval; `debug/mine_status`
    lists each mine's state.
- **Stations** (barrel GUIs with an armor_stand marker) share one driver, `station/`. Each is declared in
  `init/asset/station` as `asset.station.<id> = {name, color, icon, breakable?, modes:[{id, label, icon,
  craft? | main?, enter?}]}`; the per-feature folders only hold what a mode does:
  | station | modes |
  |---|---|
  | `smithy` 工房 | 武器 `craft/weapon/forge/craft` / 防具 `craft/equip/craft` |
  | `enhance` 強化台 | 強化 `craft/weapon/upgrade/craft` / 付与 `craft/equip_magic/craft` |
  | `magic` 魔法台 (breakable) | 作成 `magic/crafter/{main,enter}` / 研究 `craft/magic/research/{main,enter}` |
  | `job` Jobステーション | one mode, `job/station/{main,enter}` (7 per page: slots 1–7, arrows 0/8, 戻る 18) |
  - Markers are tagged `station` with `data.station = {id, mode, main|craft}`; `tick` has one line for all of
    them → `station/tick`: re-place a missing barrel (or, if `breakable`, return a spawn egg via
    `station/give_egg` and remove itself), decorate (`station/decorate`), enter the mode
    (`station/enter_mode` clears UI items, copies the mode's function, sets the title `name [label]`, puts the
    mode button in slot 20 and, for `craft` modes, the lime button in slot 26, then runs `enter`), then
    run the mode: a `craft` mode is called when the slot-26 button is taken; a `main` mode runs every tick.
  - Taking the slot-20 button cycles modes (`station/next_mode`), refused while the barrel holds anything
    but UI items. UI items must carry one of the markers `station_ui` / `button` / `crafter_ui` / `job_ui`:
    those are what `enter_mode` clears, what `next_mode` doesn't count, and what `no_barrel` deletes from
    the drops of a broken barrel.
  - **Prefer adding a mode to an existing station over adding a new station.** When a new feature needs a
    barrel GUI, first check whether it fits as a mode of a station with a similar role (e.g. another
    "make an item from materials" screen → a mode of 工房; another "modify the item in slot 9" screen →
    a mode of 強化台). Likewise, if existing stations turn out to overlap in role, merge them into one
    station with modes. Only add a separate station when no existing one fits.
  - A new station or mode is a registry line plus its `craft` (or `main`/`enter`) function. Place one with
    `test:debug/spawn_station {id:<id>}` (also listed in the debug menu). `station/migrate` (run from
    `init/`) converts markers placed before stations were merged (old per-station tags).

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

Turn-based battle (`battle/`) uses the same formulas as real time, through shared pieces:
- Sword damage: `attack/prepare_damage` reads `storage test: attack.player` (the weapon's custom_data).
  Real time fills it from the main hand (`attack/prepare`); battle fills it from `battle.actor_weapon.item`,
  cached at turn start (`turn_start_player`), because the item UI swaps the main hand for action items.
- Magic: `magic/pay` (MP + burnout, magic_efficiency; fails when MP is short) and `magic/prepare_damage`
  (magic_damage_bonus, `damage/pre_magic`, effect_damage) are used by both `magic/` and
  `battle/action/skill_cast/apply_*`.
- Stats are recalculated with `status/refresh {status}`, which skips non-players and players holding a
  battle UI item in the main hand (`status/ui_in_hand`: `battle_action` / `active_skill` / `battle_item_pick`).
  `equip/recalc` and `status/recalc` use the same check, so armor changed outside your own action applies at
  once. `battle/turn_start_player` rebuilds everything (`equip/rebuild_status`) and the wand bonus while the
  real weapon is still in hand. Use `status/refresh` instead of `status/update` in anything a battle action
  can reach.
- Wand bonus: `magic/wand_bonus` sums `magic_damage_bonus` from both hands' custom_data into
  `test.magic.wand_bonus`, added by `magic/prepare_damage`.
- Every action ends in `battle/turn_end`, which runs `battle/proc_all` (equipment slots, then rewards) before
  `check_end`. Rewards are paid per kill: `damage/kill` tags a battle enemy `battle_reward_pending`
  (it's deleted at the end of that tick) and `proc_all` → `battle/grant_reward` pays everyone tagged
  `battle_reward_recipient`. `grant_reward` rolls drops once per enemy (material counts via
  `item/material/roll_drops`, rng key `material_drop`; whether each equipment drops via
  `equip/drop/roll_all`, key `equip_drop`) into `battle.temporary.{material_hits,equip_hits}` and logs them
  (`battle/drop_log`); `grant_reward_to_player` only hands them out, so everyone gets the same materials and
  the same equipment ids (only each piece's rarity/substats are rolled per player in `equip/drop/give`).
  Returning from a battle (`return_member*`) clears buffs and `turn_order`.
  Kills outside battle (test:action, field first strikes) are paid by one `tick` line before the kill line →
  `reward/field_kill` (everyone within 32 blocks; `dummy` excluded), never mid-damage.
- Player actions: 攻撃 / スキル / アイテム (`action/item` chat list or `ui/item_hover_*` minecart →
  `action/item_use` → `consumable/use`) / 防御 / 逃げる (`action/flee`; the last living player ending the
  battle without a result). An action with no valid target (`action/no_target`) re-shows the menu
  without using the turn.
- Battle minecarts (27 slots) list entries in slots 0–25; the confirm/cast button is slot 26.
- Joining mid-battle: hitting the field's `battle_entrance` (shown with particles from `tick`) runs
  `battle/join` at it. `enter_arena` counts members on the marker with the same battle id.
- Revive (`status/revive {percent}` on a fallen player; `status/revive_pick {radius}` tags one
  `revive_target` and returns 0 if there's none — call it before spending anything): consumable kind
  `revive`, magic effect `revive` (aoe only: battle `apply_aoe`, real-time `magic/aoe/revive`), job skill
  kind `revive` (both handlers). In battle a fallen player is just HP ≤ 0 (skipped by `turn_start`); in
  test:action it is `downed`, which no longer recovers through passive regen, and can't cast or use skills.

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

- **Keep all player-facing text as short as possible** — item lore, chat messages, button/item names,
  GUI titles. Prefer a compact label + value over a sentence (e.g. `自動使用: 3回ごと`, `✚ HP回復 20%+10`,
  `命中時50%: 毒 x1`, event names like `被ダメージ時`), and don't explain in lore what the item name or
  the station already makes obvious (e.g. how/where to socket a rune). When adding new text, match the
  length of the existing lore lines rather than writing full explanations.

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
- **Barrel-based GUIs** (the stations' `main` modes such as `magic/crafter/`, `craft/magic/research/`,
  `job/station/`, and the minecart-based battle menus
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
