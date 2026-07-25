execute if dimension test:turn if entity @e[tag=hit,tag=enemy] unless score @s test.battle.id matches 1.. run function test:battle/start

execute if entity @e[tag=hit,tag=battle_marker] run function test:battle/join
execute as @e[tag=hit,tag=!battle_marker] run function test:damage/

tag @e remove hit