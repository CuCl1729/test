scoreboard players set #arena_1 test.arena.occupied 0
scoreboard players set #arena_2 test.arena.occupied 0
scoreboard players set #arena_3 test.arena.occupied 0
scoreboard players set #arena_4 test.arena.occupied 0

execute in test:arena run kill @e[tag=battle_marker]
execute in test:turn run kill @e[tag=battle_entrance]

execute as @a run function test:debug/reset_battle_state
execute in test:turn as @e[tag=enemy] run function test:debug/reset_battle_state

# test:arena に敵が残っているのは前回までのテストの残骸なので、リセットではなく削除する
execute in test:arena run kill @e[tag=enemy]