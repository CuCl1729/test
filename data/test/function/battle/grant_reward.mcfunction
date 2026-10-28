#> test:battle/grant_reward
# @s = 倒された敵。その敵の報酬(経験値・ドロップ・装備のドロップ・職業の経験値)を、battle_reward_recipient の付いた
# プレイヤー全員に渡す。ターン制では手番の終わり(test:battle/proc_all)に、先制攻撃では test:battle/preemptive_kill から呼ぶ

tag @s remove battle_reward_pending

execute store result score #reward test.temporary run scoreboard players get @s test.status.exp
# ドロップの表(宣言の無い敵では空のまま。前の敵の値が残らないよう先に空にする)
data modify storage test: battle.temporary.loot_table set value ""
data modify storage test: battle.temporary.loot_table set from entity @s data.loot_table
data modify storage test: battle.temporary.equip_drops set value []
data modify storage test: battle.temporary.equip_drops set from entity @s data.equip_drops

execute as @a[tag=battle_reward_recipient] run function test:battle/grant_reward_to_player
