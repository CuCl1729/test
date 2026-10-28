#> test:battle/return_member
# @s = 戦闘から戻る参加者(勝敗が付いたときの生存者と、逃げた人)

# 戦闘中のバフ・デバフは持ち越さない(フィールドでは時間が進まないため、止まったまま次の戦闘に残ってしまう)。
# 防具の自動発動の残った予約も、フィールドで実行しないよう消す
function test:buff/clear {reason:"battle_end"}
execute if entity @s[type=player] run function test:equip/proc/clear_queue

execute store result storage test: battle.temporary.x int 1 run scoreboard players get @s test.battle.return_x
execute store result storage test: battle.temporary.y int 1 run scoreboard players get @s test.battle.return_y
execute store result storage test: battle.temporary.z int 1 run scoreboard players get @s test.battle.return_z

scoreboard players set @s test.battle.id 0
tag @s remove battle_member

execute in test:turn run function test:battle/return_member_tp with storage test: battle.temporary