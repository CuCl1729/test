#> test:status/gear
# @s = プレイヤー。@macro status: ステータス名。装備だけから作る取り分(test.status.gear.<名前>)を
# 作り直して 1 を返す。作り直せなかったら 0 を返し、前のキャッシュはそのまま残す。
# そのとき理由を #gear_err test.buff.work に入れる(1: 32bitの範囲外 / 2: 本物の武器の控えが無い)。
#
# ターン制の戦闘中、メインハンドが行動UIのアイテムのときは手に本物の武器が無い。そのときは最後に
# 本物の武器で作ったキャッシュをそのまま使う(武器の補正を失わない)。キャッシュがまだ無い場合
# (このしくみが入る前からUIを持っていた人)だけ、手番の始めに目印へ控えた本物の武器から作り直す。
# 職業・レベルのボーナスはキャッシュに入れないので、UIを持っている間にボーナスが変わっても
# 古い合計を使い回すことはない(合流は test:status/compose)

scoreboard players set #gear_err test.buff.work 0
scoreboard players set #gear_ui test.buff.work 0
execute if function test:status/ui_in_hand run scoreboard players set #gear_ui test.buff.work 1

$execute if score #gear_ui test.buff.work matches 1 if score @s test.status.gear.$(status) matches -2147483648.. run return 1

execute store result storage test: status_gear.arg.battle int 1 run scoreboard players get @s test.battle.id
scoreboard players set #gear_ok test.buff.work 1
execute if score #gear_ui test.buff.work matches 1 store result score #gear_ok test.buff.work run function test:status/gear/weapon_saved with storage test: status_gear.arg
execute if score #gear_ok test.buff.work matches 0 run scoreboard players set #gear_err test.buff.work 2
execute if score #gear_err test.buff.work matches 2 run return 0
execute if score #gear_ui test.buff.work matches 0 run function test:status/gear/weapon_live

$execute store result score #gear_ok test.buff.work run function test:status/gear/one {status:"$(status)"}
execute if score #gear_ok test.buff.work matches 0 run scoreboard players set #gear_err test.buff.work 1
return run scoreboard players get #gear_ok test.buff.work
