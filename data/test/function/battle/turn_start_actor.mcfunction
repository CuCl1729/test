#> test:battle/turn_start_actor
# @s = 現在手番のエンティティ

execute if entity @s[type=player] run function test:battle/turn_start_player
execute unless entity @s[type=player] run function test:battle/turn_start_enemy