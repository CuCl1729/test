execute store result storage test: circle.Radius double 0.01 run scoreboard players get #cone test.temporary
scoreboard players remove #cylinder test.range 1

scoreboard players operation #cone test.temporary += #cone test.scale
function test:scan/circle/ with storage test: cone

scoreboard players operation #temp test.temporary = #cone test.temporary
scoreboard players operation #temp test.temporary /= #cone test.scale
scoreboard players operation #temp test.temporary %= #cone test.repeat

execute if score #temp test.temporary matches 0 run function test:scan/cone/wall

teleport @s ^ ^ ^1
execute if score #cone test.temporary < #temp test.range at @s run function test:scan/cone/main
execute unless score #cone test.temporary < #temp test.range run function test:scan/cone/end