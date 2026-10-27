#> test:item/consumable/build
# @macro id: 消耗品のid。asset.consumable.<id> の定義から、消耗品のアイテムを storage test: loot.item に作る
# (個数は呼び出し側が loot.item.count に入れ、渡すのは test:loot/give)。定義が無いidなら0、作れたら1を返す

$execute unless data storage test: asset.consumable.$(id) run return 0

data remove storage test: loot.item
$data modify storage test: loot.item.id set from storage test: asset.consumable.$(id).item
$data modify storage test: loot.item.components."minecraft:custom_data" set value {test:{consumable:"$(id)"}}
data modify storage test: loot.item.components."minecraft:custom_name" set value {text:"",italic:false,color:"green"}
$data modify storage test: loot.item.components."minecraft:custom_name".text set from storage test: asset.consumable.$(id).name

function test:item/weapon/lore/render
return 1
