execute as @e[tag=hit] at @s run particle end_rod ~ ~ ~ 0 0 0 0 0 force @a
execute as @e[tag=hit] run say hit
tag @e[tag=hit] remove hit
kill @s