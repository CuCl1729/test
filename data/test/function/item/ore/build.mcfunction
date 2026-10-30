#> test:item/ore/build
# @macro id/rare/stage: 原石の種類(asset.ore.<id>)・レア度(1〜5)・段階(0 なら原石、1以上なら前処理の機械で加工途中の原石)。
# storage test: loot.item に作る(個数は呼び出し側)。
# 元のアイテムは全種類 asset.ore.<id>.item(素材と同じ共通のもの。回復コンパス)で、見た目は item_model(asset.ore.<id>.model)で変える。
# custom_data.test.ore = {kind, rare} だけを持つので、同じ種類・同じレア度の原石は重なる。段階が1以上なら stage も持ち、
# 名前は「<その段階を作る機械の stage_prefix><原石の名前>」、見た目はその機械の stage_model(asset.ore_stage.s<段階>)。
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

$scoreboard players set #ore_build_stage test.temporary $(stage)
execute if score #ore_build_stage test.temporary matches ..0 run return 1
$execute unless data storage test: asset.ore_stage.s$(stage) run return run function test:debug/log {msg:"原石: 段階 $(stage) を作る前処理の機械がありません"}
$data modify storage test: ore_work.stage set value {stage:$(stage),prefix:"",model:"",name:""}
$data modify storage test: ore_work.stage.prefix set from storage test: asset.ore_stage.s$(stage).prefix
$data modify storage test: ore_work.stage.model set from storage test: asset.ore_stage.s$(stage).model
$data modify storage test: ore_work.stage.name set from storage test: asset.ore.$(id).name
function test:item/ore/build_stage with storage test: ore_work.stage
return 1
