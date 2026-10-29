#> test:status/ui_in_hand
# @s = プレイヤー。ターン制の戦闘中に、メインハンドに行動UIのアイテム(行動アイテム・スキルやアイテムのアイコン)を
# 持っていれば1、そうでなければ0を返す。持っている間は手に武器が無いので、ステータスを組み直さない
# (組み直すと武器の補正が消える。手番の始めの test:battle/turn_start_player で組み直した値を使う)

execute unless score @s test.battle.id matches 1.. run return 0
function #oh_my_dat:please
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".test.battle_action run return 1
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".test.active_skill run return 1
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".test.battle_item_pick run return 1
return 0
