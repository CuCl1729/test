execute store result score @s test.X1 run data get entity @n[tag=mark] Pos[1] 1000
execute store result entity @n[tag=mark] Pos[1] double 0.001 run scoreboard players operation @s test.X1 -= @s test.gravity

execute facing entity @n[tag=mark] feet run teleport @s ~ ~ ~ ~ ~