#> test:projectile/radial
# 起動ごとに水平の基準角を抽選し、各弾を基準角 + 360 × index / count に向ける。
scoreboard players set #radial_index test.temporary 0
scoreboard players operation #radial_count test.temporary = @s test.multi_shot
execute if score #radial_count test.temporary matches ..0 run scoreboard players set #radial_count test.temporary 1
execute store result score #radial_base test.temporary run function test:rng/roll {key:"device_direction",min:0,max:359999}
scoreboard players set #radial_circle test.temporary 360000
scoreboard players set @s test.repeat 0
data modify storage test: out set value 0.0f
function test:projectile/radial_loop


