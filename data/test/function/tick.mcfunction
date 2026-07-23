#> test:tick
# 
# @private



execute as @e[tag=projectile] at @s run function test:projectile/move
execute as @a run function test:cache/slot_check
execute as @e[type=player] run function test:ui/status/
execute as @e[tag=crafter] at @s if entity @e[type=player,distance=..6] run function test:magic/crafter/main
execute as @e[tag=attract] at @s run function test:motion/player/attract/main

scoreboard players add @e[tag=time] test.time 1

execute as @e[tag=executer] at @s rotated as @n[tag=Temp] run teleport @s ~ ~ ~ ~ ~

tag @e[tag=executer] remove executer

scoreboard players reset @e[tag=kill]
kill @e[tag=kill]
