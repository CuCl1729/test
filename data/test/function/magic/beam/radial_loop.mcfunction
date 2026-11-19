#> test:magic/beam/radial_loop
# 基準角(#beam_base。度 × 1000)から 360/本数 度ずつずらして、本数ぶん出す。
# 投射の放射(test:projectile/radial)と同じ決め方
scoreboard players set #beam_circle test.temporary 360000
scoreboard players operation #beam_angle test.temporary = #beam_index test.temporary
scoreboard players operation #beam_angle test.temporary *= #beam_circle test.temporary
scoreboard players operation #beam_angle test.temporary /= #beam_count test.temporary
scoreboard players operation #beam_angle test.temporary += #beam_base test.temporary
scoreboard players operation #beam_angle test.temporary %= #beam_circle test.temporary

execute store result storage test: beam_work.yaw float 0.001 run scoreboard players get #beam_angle test.temporary
function test:magic/beam/radial_one with storage test: beam_work

scoreboard players add #beam_index test.temporary 1
execute if score #beam_index test.temporary < #beam_count test.temporary run function test:magic/beam/radial_loop
