scoreboard players remove @s test.repeat 1

execute as @e[type=!player,tag=!hit,dx=-0.5,dy=-0.1,dz=-0.5] positioned ~-1 ~-1 ~-1 if entity @s[dx=0.5,dy=0.1,dz=0.5] run function test:scan/hit

particle end_rod ~ ~ ~ 0 0 0 0 0

execute if score @s test.repeat matches 0.. positioned ^ ^ ^1 run function test:scan/ray_cast/
execute if score @s test.repeat matches ..0 run function test:attack/damage