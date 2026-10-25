#> test:battle/grant_reward

execute store result score #reward test.temporary run scoreboard players get @s test.status.exp
data modify storage test: battle.temporary.loot_table set from entity @s data.loot_table
# 完成品の装備のドロップ表(宣言の無い敵では空のまま。前の敵の値が残らないよう先に空にする)
data modify storage test: battle.temporary.equip_drops set value []
data modify storage test: battle.temporary.equip_drops set from entity @s data.equip_drops

execute as @a[tag=battle_member,distance=..64] run function test:battle/grant_reward_to_player with storage test: battle.temporary