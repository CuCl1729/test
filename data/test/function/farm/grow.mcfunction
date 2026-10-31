#> test:farm/grow
# @s = 魔法作物。@macro id/stage/next_at: 状態。ゲーム時間が next_at を過ぎていれば、過ぎた分の段階をまとめて進める
# (長く留守にした後でも、戻ってから1秒に1段階ずつ追いつくのではなく、すぐ今の段階になるように)

$data modify storage test: farm_work.def set from storage test: asset.magic_crop.$(id)
execute store result score #farm_last test.temporary run data get storage test: farm_work.def.last
$scoreboard players set #farm_stage test.temporary $(stage)
execute if score #farm_stage test.temporary >= #farm_last test.temporary run return 0
execute store result score #farm_now test.temporary run time query gametime
$scoreboard players set #farm_next test.temporary $(next_at)
execute if score #farm_now test.temporary < #farm_next test.temporary run return 0

# 進む段階の数 k = (今 − next_at) ÷ 1段階の時間 + 1
execute store result score #farm_step test.temporary run data get storage test: farm_work.def.step
scoreboard players operation #farm_k test.temporary = #farm_now test.temporary
scoreboard players operation #farm_k test.temporary -= #farm_next test.temporary
scoreboard players operation #farm_k test.temporary /= #farm_step test.temporary
scoreboard players add #farm_k test.temporary 1
scoreboard players operation #farm_stage test.temporary += #farm_k test.temporary
execute if score #farm_stage test.temporary > #farm_last test.temporary run scoreboard players operation #farm_stage test.temporary = #farm_last test.temporary
scoreboard players operation #farm_k test.temporary *= #farm_step test.temporary
scoreboard players operation #farm_next test.temporary += #farm_k test.temporary
execute store result entity @s data.crop.stage int 1 run scoreboard players get #farm_stage test.temporary
execute store result entity @s data.crop.next_at int 1 run scoreboard players get #farm_next test.temporary
function test:farm/look with entity @s data.crop
$function test:debug/log {msg:"魔法作物が育った: $(id)"}
