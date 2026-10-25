#> test:item/weapon/lore/section_set
# @macro set: 防具のシリーズid。見出し「セット効果: <シリーズ名>」の下に、
# (2部位)のステータスと、(4部位)の特殊効果の説明(bonus4[].desc)を描く

data remove storage test: lore_work.set_def
$data modify storage test: lore_work.set_def set from storage test: asset.equip.sets[{id:"$(set)"}]
execute unless data storage test: lore_work.set_def.id run return 0

data modify storage test: loot.item.components."minecraft:lore" append value [{text:""}]
function test:item/weapon/lore/line_begin
data modify storage test: lore_work.line append value {text:"セット効果: ",color:"gray"}
data modify storage test: lore_work.line append value {text:"",color:"green"}
data modify storage test: lore_work.line[-1].text set from storage test: lore_work.set_def.label
function test:item/weapon/lore/commit

execute if data storage test: lore_work.set_def.bonus2[0] run data modify storage test: loot.item.components."minecraft:lore" append value [{text:"(2部位)",italic:false,color:"dark_gray"}]
data modify storage test: lore_work.sub_queue set value []
data modify storage test: lore_work.sub_queue set from storage test: lore_work.set_def.bonus2
function test:item/weapon/lore/substatus_loop

execute if data storage test: lore_work.set_def.bonus4[0] run data modify storage test: loot.item.components."minecraft:lore" append value [{text:"(4部位)",italic:false,color:"dark_gray"}]
data modify storage test: lore_work.desc_queue set value []
data modify storage test: lore_work.desc_queue set from storage test: lore_work.set_def.bonus4
function test:item/weapon/lore/set_desc_loop
