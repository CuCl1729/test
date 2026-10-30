#> test:item/ore/build
# @macro id/rare: 原石の種類(asset.ore.<id>)とレア度(1〜5)。原石を storage test: loot.item に作る(個数は呼び出し側)。
# 元のアイテムは全種類 asset.ore.<id>.item(かまどで焼けない paper)で、見た目は item_model(asset.ore.<id>.model)で変える。
# custom_data.test.ore = {kind, rare} だけを持つので、同じ種類・同じレア度の原石は重なる。
# 名前の色がレア度(1 白 / 2 緑 / 3〜5 は装備と同じ 3 dark_aqua・4 dark_purple・5 gold)。定義が無いidなら0、作れたら1を返す

$execute unless data storage test: asset.ore.$(id) run return 0

data remove storage test: loot.item
$data modify storage test: loot.item.id set from storage test: asset.ore.$(id).item
$data modify storage test: loot.item.components."minecraft:item_model" set from storage test: asset.ore.$(id).model
$data modify storage test: loot.item.components."minecraft:custom_data" set value {test:{ore:{kind:"$(id)",rare:$(rare)}}}
data modify storage test: loot.item.components."minecraft:custom_name" set value {text:"",italic:false,color:"white"}
$data modify storage test: loot.item.components."minecraft:custom_name".text set from storage test: asset.ore.$(id).name

$data modify storage test: ore_work.rare set value $(rare)
execute if data storage test: ore_work{rare:2} run data modify storage test: loot.item.components."minecraft:custom_name".color set value "green"
execute if data storage test: ore_work{rare:3} run data modify storage test: loot.item.components."minecraft:custom_name".color set value "dark_aqua"
execute if data storage test: ore_work{rare:4} run data modify storage test: loot.item.components."minecraft:custom_name".color set value "dark_purple"
execute if data storage test: ore_work{rare:5} run data modify storage test: loot.item.components."minecraft:custom_name".color set value "gold"
return 1
