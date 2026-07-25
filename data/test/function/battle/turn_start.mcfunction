#> test:battle/turn_start
# @s = 戦闘マーカー

scoreboard players set @s test.battle.acting 1

scoreboard players operation #battle_turn test.battle.id = @s test.battle.id
scoreboard players operation #battle_turn test.battle.current_turn = @s test.battle.current_turn

execute as @e[tag=battle_member,distance=..64] if score @s test.battle.id = #battle_turn test.battle.id if score @s test.battle.turn_order = #battle_turn test.battle.current_turn run function test:battle/turn_start_actor