#> test:item/material/build
# @macro id: 素材のid。asset.material.<id> の定義から、素材のアイテムを storage test: loot.item に作る
# (個数は呼び出し側が loot.item.count に入れ、渡すのは test:loot/give)。定義が無いidなら0、作れたら1を返す

$execute unless data storage test: asset.material.$(id) run return 0

data remove storage test: loot.item
$data modify storage test: loot.item.id set from storage test: asset.material.$(id).item
$data modify storage test: loot.item.components."minecraft:custom_data".test set from storage test: asset.material.$(id).data
data modify storage test: loot.item.components."minecraft:custom_name" set value {text:"",italic:false}
$data modify storage test: loot.item.components."minecraft:custom_name".text set from storage test: asset.material.$(id).name
return 1
