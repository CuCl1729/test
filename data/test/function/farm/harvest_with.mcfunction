#> test:farm/harvest_with
# @s = プレイヤー。@macro id/stage: 右クリックした魔法作物の状態(ほかのキーも渡ってくるが使わない)。
# 育ちきっていなければ残りの時間を出す。育ちきっていれば、エッセンス(個数は rng のキー crop_yield)と、確率で種(crop_seed)を
# 足元に落とし、作物を最初の段階に戻して、また育て始める(植え直し不要)

$data modify storage test: farm_work.def set from storage test: asset.magic_crop.$(id)
execute store result score #farm_last test.temporary run data get storage test: farm_work.def.last
execute store result score #farm_now test.temporary run time query gametime
$scoreboard players set #farm_stage test.temporary $(stage)
execute if score #farm_stage test.temporary < #farm_last test.temporary run return run function test:farm/remaining with storage test: farm_work.t

function test:farm/harvest_yield with storage test: farm_work.def
execute store result score #farm_step test.temporary run data get storage test: farm_work.def.step
scoreboard players operation #farm_step test.temporary += #farm_now test.temporary
execute as @n[type=interaction,tag=gather_target] run function test:farm/reset
