#> test:battle/turn_start_player
# @s = 現在手番のプレイヤー

execute if score @s test.settings.battle_ui matches 1 run function test:battle/ui/chat
execute if score @s test.settings.battle_ui matches 2 run function test:battle/ui/item