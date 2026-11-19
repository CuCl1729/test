#> test:magic/dash/start
# @s = 詠唱者(プレイヤー)。@macro distance = 水平距離(ブロック)。
# プレイヤー以外・ダウン中・HP0以下・ターン制の戦闘中は何もしない。
# 呼び出し元(一定間隔の発生源など)の実行位置は @s と限らないため、まず at @s で自分の位置に戻す。
# そのteleportで既存の速度(前の慣性)を即座に止める(fallDistanceは引き継がれ、向きも ~ ~ で変えない)。
execute unless entity @s[type=player] run return 0
execute if entity @s[tag=downed] run return 0
execute unless score @s test.status.hp matches 1.. run return 0
execute if score @s test.battle.id matches 1.. run return 0

function #oh_my_dat:please
scoreboard players operation #dash_owner test.temporary = @s OhMyDatID

execute at @s run teleport @s ~ ~ ~ ~ ~

data remove storage test: dash_work
$data modify storage test: dash_work.distance set value $(distance)
data modify storage test: dash_work.yaw set from entity @s Rotation[0]

execute at @s summon marker run function test:magic/dash/vector with storage test: dash_work

function test:magic/dash/spawn
