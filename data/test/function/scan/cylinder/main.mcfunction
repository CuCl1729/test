scoreboard players add #cylinder test.temporary 1
function test:scan/circle/ with storage test: cylinder

teleport @s ^ ^ ^0.5

execute if score #cylinder test.temporary < #cylinder test.range at @s run function test:scan/cylinder/main
execute unless score #cylinder test.temporary < #cylinder test.range run kill @s