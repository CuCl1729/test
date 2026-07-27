#> test:battle/grant_reward

execute store result score #reward test.temporary run scoreboard players get @s test.status.exp
data modify storage test: battle.tmporary.loot_table set from entity @s data.loot_table

execute as @a[tag=battle_member,distance=..64] run function test:battle/grant_reward_to_player with storage test: battle.temporary