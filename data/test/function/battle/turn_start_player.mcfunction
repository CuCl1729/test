#> test:battle/turn_start_player
# @s = 現在手番のプレイヤー(実行位置は戦闘マーカー)

# 手番の制限時間(tick)。test:battle/turn_timer_tickが減らし、0で自動的に防御させる
execute store result score @e[tag=battle_marker,sort=nearest,limit=1] test.battle.turn_timer run data get storage test: asset.config.turn_time 20

# 手番の始めに、今の装備(手に持っている本物の武器を含む)でステータスを全部組み直す。行動UIのアイテムを
# 持っている間は組み直さない(test:status/ui_in_hand)ので、ここで組み直した値を手番の間使う。杖の補正も同じ
function test:equip/rebuild_status
function test:magic/wand_bonus

# 戦闘中は毎秒の自動回復を止めている(status/regene/参照)ので、手番が回ってくるたびに
# hp_regene/mp_regeneのぶんだけ1回回復させる。どちらも最大値でクランプ済み。
# 行動UIを出す前に済ませることで、行動を選ぶ時点で正しい残量を見て判断できる
function test:status/regene/hp
function test:status/regene/mp

function test:battle/open_player_turn
