#> test:battle/turn_start
# @s = 戦闘マーカー

scoreboard players operation #battle_turn test.battle.id = @s test.battle.id
scoreboard players operation #battle_turn test.battle.current_turn = @s test.battle.current_turn

# 現在のturn_orderの持ち主が既に戦闘不能(hp<=0)になっている場合、
# ここで見つからずactingだけ立って詰まってしまうため、次の手番へ進めて探し直す。
# test.battle.turn_start_retryはmember_countを超えたら打ち切る安全装置(無限再帰防止)。
scoreboard players set #turn_actor_found test.temporary 0
execute as @e[tag=battle_member,distance=..64] if score @s test.battle.id = #battle_turn test.battle.id if score @s test.battle.turn_order = #battle_turn test.battle.current_turn unless score @s test.status.hp matches ..0 run scoreboard players set #turn_actor_found test.temporary 1

execute if score #turn_actor_found test.temporary matches 0 run scoreboard players add @s test.battle.turn_start_retry 1

# 超えたかどうかを明示的にset(1)/set(0)で判定する(store successはrunなしだと
# if条件を無視して常に成功扱いになってしまうため使わない)
scoreboard players set #turn_retry_exceeded test.temporary 0
execute if score #turn_actor_found test.temporary matches 0 if score @s test.battle.turn_start_retry > @s test.battle.member_count run scoreboard players set #turn_retry_exceeded test.temporary 1

execute if score #turn_retry_exceeded test.temporary matches 1 run scoreboard players set @s test.battle.turn_start_retry 0
execute if score #turn_retry_exceeded test.temporary matches 1 run function test:battle/check_end
execute if score #turn_retry_exceeded test.temporary matches 1 run return 0

execute if score #turn_actor_found test.temporary matches 0 run scoreboard players add @s test.battle.current_turn 1
execute if score #turn_actor_found test.temporary matches 0 if score @s test.battle.current_turn > @s test.battle.member_count run scoreboard players set @s test.battle.current_turn 1
# #turn_actor_found/#battle_turn は共有スコアなので、再帰呼び出し(function test:battle/turn_start)の中で
# 値が上書きされる。呼び出し後に同じ共有スコアを条件にreturnするとその上書き後の値を見てしまい
# 判定が効かず、呼び出し元でも同じ実行者へ二重にturn_start_actorを呼んでしまう。
# 「return run function」で再帰呼び出しと同時に必ず打ち切ることで、この上書きの影響を受けないようにする
execute if score #turn_actor_found test.temporary matches 0 run return run function test:battle/turn_start

execute if score #turn_actor_found test.temporary matches 1 run scoreboard players set @s test.battle.turn_start_retry 0
execute if score #turn_actor_found test.temporary matches 1 run scoreboard players set @s test.battle.acting 1
execute if score #turn_actor_found test.temporary matches 1 at @s as @e[tag=battle_member,distance=..64] if score @s test.battle.id = #battle_turn test.battle.id if score @s test.battle.turn_order = #battle_turn test.battle.current_turn run function test:battle/turn_start_actor
