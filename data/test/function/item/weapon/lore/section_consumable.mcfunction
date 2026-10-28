#> test:item/weapon/lore/section_consumable
# @macro consumable: 消耗品のid。消耗品のアイテムの説明文に、今の定義の効果(consumable/lore/<kind>)と、
# 装備の枠に設定したときの使われ方(イベント every 回ごとに1個)を書く

$execute unless data storage test: asset.consumable.$(consumable) run return 0

function test:item/weapon/lore/header {title:"効果"}
$data modify storage test: consumable_work.lore set from storage test: asset.consumable.$(consumable).effect
function test:item/weapon/lore/consumable_effect with storage test: consumable_work.lore

data modify storage test: loot.item.components."minecraft:lore" append value [{text:""}]
function test:item/weapon/lore/line_begin
data modify storage test: lore_work.line append value {text:"自動使用: ",color:"gray"}
$data modify storage test: lore_work.n set from storage test: asset.consumable.$(consumable).every
function test:item/weapon/lore/num
data modify storage test: lore_work.line append value {text:"回ごと",color:"gray"}
function test:item/weapon/lore/commit
