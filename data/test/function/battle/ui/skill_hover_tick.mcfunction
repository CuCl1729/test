#> test:battle/ui/skill_hover_tick
# @s = バトル参加中のプレイヤー(実行位置は@sに同期済み)。メインハンドが「スキル」アイテムかどうかで
# 頭に追従するトロッコの出し入れを行う

function #oh_my_dat:please

execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".test{battle_action:"skill"} run function test:battle/ui/skill_hover_show
execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".test{battle_action:"skill"} run function test:battle/ui/skill_hover_hide

# 攻撃アイテムを持っている間、敵が2体以上なら対象選択トロッコをあらかじめ召喚しておく
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".test{battle_action:"attack"} run function test:battle/ui/attack_hover_show
execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".test{battle_action:"attack"} run function test:battle/ui/attack_hover_hide

# 対象選択トロッコ(通常攻撃/投射魔法どちらの対象選択中も)は手持ちアイテムに関係なく常に追従させる
execute if entity @e[tag=target_minecart,distance=..8] run function test:battle/ui/target_hover_show
