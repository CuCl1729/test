#> test:battle/turn_start_player
# @s = 現在手番のプレイヤー

# 戦闘中は毎秒の自動回復を止めている(status/regene/参照)ので、手番が回ってくるたびに
# hp_regene/mp_regeneのぶんだけ1回回復させる。どちらも最大値でクランプ済み。
# 行動UIを出す前に済ませることで、行動を選ぶ時点で正しい残量を見て判断できる
function test:status/regene/hp
function test:status/regene/mp

# item式UIはこの後メインハンドが行動選択アイテムに差し替わってしまうため、本来の武器が範囲攻撃
# 対応かどうか(と対応していればその倍率)を差し替え前のこの時点でキャッシュしておく。chat式は
# メインハンドが差し替わらないが、同じ場所で計算して両UI共通の判定にする
function #oh_my_dat:please

scoreboard players set @s test.battle.weapon_aoe 0
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".test{aoe_attack:1b} run scoreboard players set @s test.battle.weapon_aoe 1
execute if score @s test.battle.weapon_aoe matches 1 store result score @s test.battle.weapon_aoe_multiplier run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".weapon[{type:"aoe_multiplier"}].value

# 武器の「命中時に付与するバフ」も同じ理由でここで控えておく。手番は常に1人ずつ進むので、
# 共有のストレージに置いても他の参加者と混ざることはない
data modify storage test: battle.actor_weapon set value {}
data modify storage test: battle.actor_weapon.buff_on_hit set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".test.buff_on_hit

execute if score @s test.settings.battle_ui matches 1 run function test:battle/ui/chat
execute if score @s test.settings.battle_ui matches 2 run function test:battle/ui/item