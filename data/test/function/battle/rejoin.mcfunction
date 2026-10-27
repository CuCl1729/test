#> test:battle/rejoin
# @s = ログインし直したプレイヤー(test:tickから、at @s)。test.leave_game はログアウトするたびに増える。
# 戦闘中にログアウトしていた場合:
# - 戦闘がまだ続いていれば、そのまま参加者として残す(手番はturn_startが次に回してくる)
# - 留守の間に戦闘が終わっていれば、battle/endと同じように元の場所(倒れていたら安全地帯)へ戻す
# どちらの場合も、手元に残った行動UIのアイテムは消す(戦闘マーカーの状態は他の人の手番なので触らない)

scoreboard players reset @s test.leave_game
execute unless score @s test.battle.id matches 1.. run return 0

function test:battle/ui/clear_items

scoreboard players operation #rejoin test.battle.id = @s test.battle.id
scoreboard players set #rejoin_running test.temporary 0
execute in test:arena as @e[tag=battle_marker] if score @s test.battle.id = #rejoin test.battle.id run scoreboard players set #rejoin_running test.temporary 1
execute if score #rejoin_running test.temporary matches 1 run return run tellraw @s [{text:"戦闘に戻りました。次の自分の手番から行動できます",color:yellow}]

tellraw @s [{text:"離れている間に戦闘が終わったため、元の場所に戻りました",color:yellow}]
execute if score @s test.status.hp matches 1.. run return run function test:battle/return_member
function test:battle/return_member_defeated
