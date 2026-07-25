#> test:battle/turn_start_player
# @s = 現在手番のプレイヤー。固定設定に応じたUIを開く(中身は今後実装)

execute if score @s test.settings.battle_ui matches 0 run function test:battle/ui/gui
execute if score @s test.settings.battle_ui matches 1 run function test:battle/ui/chat
execute if score @s test.settings.battle_ui matches 2 run function test:battle/ui/item