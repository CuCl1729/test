#> test:battle/turn_start_actor
# @s = 現在手番のエンティティ

execute if score #log_battle test.debug.enabled matches 1 run function test:debug/trace/battle/turn_start

execute if score @s test.status.hp matches ..0 run function test:battle/turn_end
execute unless score @s test.status.hp matches ..0 if entity @s[type=player] run function test:battle/turn_start_player
execute unless score @s test.status.hp matches ..0 unless entity @s[type=player] run function test:battle/turn_start_enemy