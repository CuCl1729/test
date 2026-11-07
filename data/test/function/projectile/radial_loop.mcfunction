scoreboard players operation #radial_angle test.temporary = #radial_index test.temporary
scoreboard players operation #radial_angle test.temporary *= #radial_circle test.temporary
scoreboard players operation #radial_angle test.temporary /= #radial_count test.temporary
scoreboard players operation #radial_angle test.temporary += #radial_base test.temporary
scoreboard players operation #radial_angle test.temporary %= #radial_circle test.temporary
execute store result storage test: radial_work.yaw float 0.001 run scoreboard players get #radial_angle test.temporary
function test:projectile/radial_one with storage test: radial_work
scoreboard players add #radial_index test.temporary 1
execute if score #radial_index test.temporary < #radial_count test.temporary run function test:projectile/radial_loop
