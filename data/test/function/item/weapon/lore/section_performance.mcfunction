#> test:item/weapon/lore/section_performance
# 性能: 射程、属性ごとのダメージ式(test:damage/pre_attackが読むdamage.<属性>.{atk,hp_max,def,base})、杖の魔法ダメージ

function test:item/weapon/lore/header {title:"性能"}

# 射程
execute if data storage test: lore_work.data.weapon[{type:"reach"}] run function test:item/weapon/lore/line_begin
execute if data storage test: lore_work.data.weapon[{type:"reach"}] run data modify storage test: lore_work.line append value {text:"➹ ",color:"white"}
execute if data storage test: lore_work.data.weapon[{type:"reach"}] run data modify storage test: lore_work.line append value {text:"射程 ",color:"gray"}
execute if data storage test: lore_work.data.weapon[{type:"reach"}] run data modify storage test: lore_work.n set from storage test: lore_work.data.weapon[{type:"reach"}].value
execute if data storage test: lore_work.data.weapon[{type:"reach"}] run function test:item/weapon/lore/num
execute if data storage test: lore_work.data.weapon[{type:"reach"}] run data modify storage test: lore_work.line append value {text:"ブロック",color:"aqua"}
execute if data storage test: lore_work.data.weapon[{type:"reach"}] run function test:item/weapon/lore/commit

# 属性ごとのダメージ式(damageにある属性だけ)
function test:item/weapon/lore/damage_line with storage test: loot.table.element_display[{elem:"physics"}]
function test:item/weapon/lore/damage_line with storage test: loot.table.element_display[{elem:"fire"}]
function test:item/weapon/lore/damage_line with storage test: loot.table.element_display[{elem:"water"}]
function test:item/weapon/lore/damage_line with storage test: loot.table.element_display[{elem:"wood"}]
function test:item/weapon/lore/damage_line with storage test: loot.table.element_display[{elem:"metal"}]
function test:item/weapon/lore/damage_line with storage test: loot.table.element_display[{elem:"earth"}]

# 杖の魔法ダメージ増加
execute if data storage test: lore_work.data.magic_damage_bonus run function test:item/weapon/lore/line_begin
execute if data storage test: lore_work.data.magic_damage_bonus run data modify storage test: lore_work.line append value {text:"✧ ",color:"light_purple"}
execute if data storage test: lore_work.data.magic_damage_bonus run data modify storage test: lore_work.line append value {text:"魔法ダメージ ",color:"gray"}
execute if data storage test: lore_work.data.magic_damage_bonus run data modify storage test: lore_work.line append value {text:"+",color:"aqua"}
execute if data storage test: lore_work.data.magic_damage_bonus run data modify storage test: lore_work.n set from storage test: lore_work.data.magic_damage_bonus
execute if data storage test: lore_work.data.magic_damage_bonus run function test:item/weapon/lore/num
execute if data storage test: lore_work.data.magic_damage_bonus run data modify storage test: lore_work.line append value {text:"%",color:"aqua"}
execute if data storage test: lore_work.data.magic_damage_bonus run function test:item/weapon/lore/commit
