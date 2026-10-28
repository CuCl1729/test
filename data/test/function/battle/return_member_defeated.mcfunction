#> test:battle/return_member_defeated
# @s = 戦闘終了時点で死亡している参加者

# 戦闘中のバフ・デバフと、防具の自動発動の残った予約を消す(test:battle/return_member と同じ)
function test:buff/clear {reason:"battle_end"}
execute if entity @s[type=player] run function test:equip/proc/clear_queue

scoreboard players operation @s test.status.hp = @s test.status.hp_max
scoreboard players set @s test.battle.id 0
tag @s remove battle_member

execute store result storage test: battle.temporary.x int 1 run scoreboard players get @s test.battle.return_x
execute store result storage test: battle.temporary.y int 1 run scoreboard players get @s test.battle.return_y
execute store result storage test: battle.temporary.z int 1 run scoreboard players get @s test.battle.return_z

execute in test:turn run function test:battle/goto_safe_area with storage test: battle.temporary