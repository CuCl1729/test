tag @s add executer
scoreboard players set #cylinder test.temporary 0
summon armor_stand ~ ~ ~ {Tags:[cylinder],Marker:1b}
execute as @n[tag=cylinder] at @s rotated as @n[tag=executer] run teleport @s ~ ~ ~ ~ ~
execute as @n[tag=cylinder] at @s run function test:scan/cylinder/main
tag @s remove executer