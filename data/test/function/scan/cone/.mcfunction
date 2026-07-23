tag @s add executer

data modify storage test: circle.Radius set from storage test: cone.Radius
data modify storage test: circle.Command set from storage test: cone.Command

data modify storage test: cylinder.Radius set from storage test: cone.Radius
data modify storage test: cylinder.Command set from storage test: cone.Command

execute store result storage test: circle.Range double 0.5 run scoreboard players get @s test.range

execute store result storage test: cone.Yaw float 1 run data get entity @s Rotation[0]
execute store result score #temp test.X0 run data get entity @s Rotation[1] 100
scoreboard players operation #temp test.X0 += #9000 test.constant
execute if score #temp test.X0 matches 9000 run scoreboard players remove #temp test.X0 10
execute if score #temp test.X0 matches -9000 run scoreboard players remove #temp test.X0 10

execute store result storage test: cone.Pitch float 0.01 run scoreboard players get #temp test.X0

data modify storage test: cylinder.Yaw set from storage test: cone.Yaw
data modify storage test: cylinder.Pitch set from storage test: cone.Pitch

scoreboard players operation #temp test.range = @s test.range
scoreboard players operation #temp test.range *= @s test.scale
scoreboard players operation #cylinder test.range = @s test.range

scoreboard players operation #cone test.repeat = #cone test.range
scoreboard players operation #cone test.repeat /= #cone test.scale
execute if score #cone test.repeat matches ..0 run scoreboard players set #cone test.repeat 1

scoreboard players operation #cone test.repeat *= #2 test.constant

summon armor_stand ~ ~ ~ {Tags:[cone],Marker:1b}
scoreboard players set #cone test.temporary 0
execute as @n[tag=cone] at @s rotated as @n[tag=executer] run teleport @s ~ ~ ~ ~ ~

scoreboard players operation #cone test.scale = @s test.scale

execute as @n[tag=cone] at @s run function test:scan/cone/main with storage test: circle
tag @s remove executer