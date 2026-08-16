#> test:battle/ui/skill_hover_tick
# @s = バトル参加中のプレイヤー(実行位置は@sに同期済み)。メインハンドが「スキル」アイテムかどうかで
# 頭に追従するトロッコの出し入れを行う

function #oh_my_dat:please

execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".test{battle_action:"skill"} run function test:battle/ui/skill_hover_show
execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".test{battle_action:"skill"} run function test:battle/ui/skill_hover_hide
