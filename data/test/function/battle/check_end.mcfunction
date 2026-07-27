#> test:battle/check_end

scoreboard players operation #battle_check test.battle.id = @s test.battle.id
scoreboard players set #battle_check test.temporary 0
scoreboard players set #battle_check2 test.temporary 0

execute as @e[tag=battle_member,tag=enemy,distance=..64] if score @s test.battle.id = #battle_check test.battle.id unless score @s test.status.hp matches ..0 run scoreboard players add #battle_check test.temporary 1
execute as @a[tag=battle_member,distance=..64] if score @s test.battle.id = #battle_check test.battle.id unless score @s test.status.hp matches ..0 run scoreboard players add #battle_check2 test.temporary 1

execute if score #battle_check test.temporary matches 0 run function test:battle/end_victory
execute if score #battle_check2 test.temporary matches 0 run function test:battle/end_defeat