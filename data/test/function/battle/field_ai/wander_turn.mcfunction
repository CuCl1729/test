#> test:battle/field_ai/wander_turn
# @s = 巡回中の敵。ランダムな向きへ向き直し、次に向きを変えるまでのtick数を再設定する

scoreboard players set #yaw test.buff.work 0
execute store result score #yaw test.buff.work run random value -180..180
execute store result entity @s Rotation[0] float 1 run scoreboard players get #yaw test.buff.work
data modify entity @s Rotation[1] set value 0.0f

scoreboard players set #wander_interval test.buff.work 0
execute store result score #wander_interval test.buff.work run random value 40..100
execute store result entity @s data.ai_field.wander_timer int 1 run scoreboard players get #wander_interval test.buff.work
