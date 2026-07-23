execute store result storage test: circle.Radius double 0.01 run scoreboard players get #temp test.temporary
scoreboard players add #temp test.temporary 100
function test:scan/circle/ with storage test: cone

execute if score #temp test.temporary < #cone test.temporary at @s run function test:scan/cone/wall

