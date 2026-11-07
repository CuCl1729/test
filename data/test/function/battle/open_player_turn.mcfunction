#> test:battle/open_player_turn
# @s = 手番のプレイヤー。アリーナごとに、この手番だけの装備と選択肢を保持する。

data modify entity @n[tag=battle_marker,distance=..64] data.turn set value {}
# item式UIはこの後メインハンドが行動選択アイテムに差し替わってしまうため、本来の武器が範囲攻撃
# 対応かどうか(と対応していればその倍率)を差し替え前のこの時点でキャッシュしておく。chat式は
# メインハンドが差し替わらないが、同じ場所で計算して両UI共通の判定にする
function #oh_my_dat:please

scoreboard players set @s test.battle.weapon_aoe 0
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".test{aoe_attack:1b} run scoreboard players set @s test.battle.weapon_aoe 1
execute if score @s test.battle.weapon_aoe matches 1 store result score @s test.battle.weapon_aoe_multiplier run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".weapon[{type:"aoe_multiplier"}].value

# 入力を待つ間も、武器と命中時のバフはこのアリーナの手番に属する。
data modify entity @n[tag=battle_marker,distance=..64] data.turn.actor_weapon set value {}
data modify entity @n[tag=battle_marker,distance=..64] data.turn.actor_weapon.buff_on_hit set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".test.buff_on_hit
# 通常攻撃・剣のスキルのダメージ計算用に、武器の custom_data も丸ごと控える(test:battle/action/attack_resolve)
data modify entity @n[tag=battle_marker,distance=..64] data.turn.actor_weapon.item set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data"

execute if score @s test.settings.battle_ui matches 1 run function test:battle/ui/chat
execute if score @s test.settings.battle_ui matches 2 run function test:battle/ui/item