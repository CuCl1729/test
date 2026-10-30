#> test:item/machine/build
# @macro id: 組み立てに使うアイテムのid(asset.machine_item.<id>)。storage test: loot.item に作る(item/material/build と同じ形。
# 個数は呼び出し側)。置けるもの(kind "place")は、壊したときにルートテーブルが落とすものと中身を完全にそろえる
# (そろっていないと重ならない)。定義が無いidなら0、作れたら1を返す

$execute unless data storage test: asset.machine_item.$(id) run return 0

data remove storage test: loot.item
$data modify storage test: loot.item.id set from storage test: asset.machine_item.$(id).item
$data modify storage test: loot.item.components."minecraft:custom_data" set value {test:{machine_item:"$(id)"}}
data modify storage test: loot.item.components."minecraft:custom_name" set value {text:"",italic:false}
$data modify storage test: loot.item.components."minecraft:custom_name".text set from storage test: asset.machine_item.$(id).name

$execute if data storage test: asset.machine_item.$(id){kind:"place"} run function test:item/machine/build_place
$execute if data storage test: asset.machine_item.$(id){kind:"wrench"} run function test:item/machine/build_wrench
return 1
