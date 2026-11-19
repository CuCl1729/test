#> test:magic/homing/steer
# @s = 狙う側(弾・ビーム。at @s)。homing_target が付いた相手の方へ、1 tick ぶんだけ向きを回す。
# @macro turn: 向きを変える速さ(度/秒)。1 tick の上限は turn ÷ 20 度
#
# 一度ほんとうに相手を向いて向きを読み、そこから上限ぶんだけ戻す。
# 2回の teleport は同じ tick の中なので、見えるのは最後の向きだけ
execute store result score #steer_yaw0 test.temporary run data get entity @s Rotation[0] 100
execute store result score #steer_pitch0 test.temporary run data get entity @s Rotation[1] 100

teleport @s ~ ~ ~ facing entity @e[tag=homing_target,limit=1] eyes
execute store result score #steer_yaw1 test.temporary run data get entity @s Rotation[0] 100
execute store result score #steer_pitch1 test.temporary run data get entity @s Rotation[1] 100

# 1 tick ぶんの上限(度 × 100)= turn ÷ 20 × 100 = turn × 5
$scoreboard players set #steer_max test.temporary $(turn)
scoreboard players operation #steer_max test.temporary *= #5 test.constant
scoreboard players set #steer_min test.temporary 0
scoreboard players operation #steer_min test.temporary -= #steer_max test.temporary

# yaw の差は -180..180 に畳む(真後ろの相手へ遠回りしないため)。%= は床剰余なので必ず 0 以上になる
scoreboard players operation #steer_dy test.temporary = #steer_yaw1 test.temporary
scoreboard players operation #steer_dy test.temporary -= #steer_yaw0 test.temporary
scoreboard players add #steer_dy test.temporary 18000
scoreboard players operation #steer_dy test.temporary %= #36000 test.constant
scoreboard players remove #steer_dy test.temporary 18000

scoreboard players operation #steer_dp test.temporary = #steer_pitch1 test.temporary
scoreboard players operation #steer_dp test.temporary -= #steer_pitch0 test.temporary

execute if score #steer_dy test.temporary > #steer_max test.temporary run scoreboard players operation #steer_dy test.temporary = #steer_max test.temporary
execute if score #steer_dy test.temporary < #steer_min test.temporary run scoreboard players operation #steer_dy test.temporary = #steer_min test.temporary
execute if score #steer_dp test.temporary > #steer_max test.temporary run scoreboard players operation #steer_dp test.temporary = #steer_max test.temporary
execute if score #steer_dp test.temporary < #steer_min test.temporary run scoreboard players operation #steer_dp test.temporary = #steer_min test.temporary

scoreboard players operation #steer_yaw0 test.temporary += #steer_dy test.temporary
scoreboard players operation #steer_pitch0 test.temporary += #steer_dp test.temporary

execute store result storage test: steer_work.yaw float 0.01 run scoreboard players get #steer_yaw0 test.temporary
execute store result storage test: steer_work.pitch float 0.01 run scoreboard players get #steer_pitch0 test.temporary
function test:magic/homing/steer_apply with storage test: steer_work
