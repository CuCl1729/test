#> test:debug/farm_status_line
# @s = 魔法作物。@macro id/stage/next_at: 状態。育ちきるまでの秒数 = (next_at − 今 + (last − stage − 1) × step) ÷ 20(育ちきっていれば0)

$data modify storage test: farm_work.def set from storage test: asset.magic_crop.$(id)
execute store result score #farm_last test.temporary run data get storage test: farm_work.def.last
execute store result score #farm_step test.temporary run data get storage test: farm_work.def.step
$scoreboard players set #farm_left test.temporary $(next_at)
scoreboard players operation #farm_left test.temporary -= #farm_now test.temporary
scoreboard players operation #farm_k test.temporary = #farm_last test.temporary
$scoreboard players remove #farm_k test.temporary $(stage)
scoreboard players remove #farm_k test.temporary 1
scoreboard players operation #farm_k test.temporary *= #farm_step test.temporary
scoreboard players operation #farm_left test.temporary += #farm_k test.temporary
scoreboard players set #farm_n test.temporary 20
scoreboard players operation #farm_left test.temporary /= #farm_n test.temporary
$execute if score #farm_last test.temporary matches ..$(stage) run scoreboard players set #farm_left test.temporary 0
$tellraw @a[tag=debug_farm_viewer] [{text:" $(id) ",color:"gold"},{text:"段階 $(stage)/",color:"gray"},{score:{name:"#farm_last",objective:"test.temporary"},color:"gray"},{text:" 成熟まで ",color:"gray"},{score:{name:"#farm_left",objective:"test.temporary"},color:"aqua"},{text:"秒",color:"gray"}]
