#> test:item/rune/build
# @macro id: ルーンのid。asset.rune.<id> の定義から、ルーンのアイテムを storage test: loot.item に作る(渡すのは呼び出し側が
# test:loot/give で行う)。定義が無いidなら何も作らずに0を返し、作れたら1を返す

$execute unless data storage test: asset.rune.$(id) run return 0

data remove storage test: loot.item
$data modify storage test: loot.item.id set from storage test: asset.rune.$(id).item
$data modify storage test: loot.item.components."minecraft:custom_data" set value {test:{rune:"$(id)"}}
data modify storage test: loot.item.components."minecraft:custom_name" set value {text:"",italic:false,color:"light_purple"}
$data modify storage test: loot.item.components."minecraft:custom_name".text set from storage test: asset.rune.$(id).name

function test:item/weapon/lore/render
return 1
