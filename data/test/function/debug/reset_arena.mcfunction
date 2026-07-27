scoreboard players set #arena_1 test.arena.occupied 0
scoreboard players set #arena_2 test.arena.occupied 0
scoreboard players set #arena_3 test.arena.occupied 0
scoreboard players set #arena_4 test.arena.occupied 0

execute in test:arena run kill @e[tag=battle_marker]
execute in test:turn run kill @e[tag=battle_entrance]

execute as @a[tag=battle_member] run function test:debug/reset_battle_state
execute as @e[tag=battle_member,type=!player] run function test:debug/reset_battle_state