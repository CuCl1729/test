#> test:battle/action/flee
# @s = 手番のプレイヤー。戦闘から必ず逃げられる。
# - ほかに生きているプレイヤーがいなければ、戦闘そのものを終える(test:battle/end。敵もフィールドへ戻る。勝敗は付かない)
# - いれば自分だけフィールドへ戻り(test:battle/return_member)、戦闘マーカーが手番を進める(test:battle/turn_end)

function test:battle/ui/cleanup
tellraw @a[distance=..64] ["",{selector:"@s"},{text:" は逃げ出した",color:gray}]

scoreboard players operation #flee_battle test.battle.id = @s test.battle.id
tag @s add battle_fleeing
scoreboard players set #flee_others test.temporary 0
execute as @a[tag=battle_member,tag=!battle_fleeing,distance=..64,scores={test.status.hp=1..}] if score @s test.battle.id = #flee_battle test.battle.id run scoreboard players add #flee_others test.temporary 1
tag @s remove battle_fleeing

execute if score #flee_others test.temporary matches 0 as @e[tag=battle_marker,distance=..64] if score @s test.battle.id = #flee_battle test.battle.id at @s run return run function test:battle/end

# 手番を進めてから戻る(手番の終わりの処理は、まだアリーナにいる間に済ませる。UIは上の cleanup で片付け済み)
execute as @e[tag=battle_marker,distance=..64] if score @s test.battle.id = #flee_battle test.battle.id at @s run function test:battle/turn_end
function test:battle/return_member
