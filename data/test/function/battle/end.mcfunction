#> test:battle/end

scoreboard players operation #battle_end test.battle.id = @s test.battle.id
scoreboard players operation #battle_end test.battle.arena = @s test.battle.arena

# 生存者を元の座標へ戻す
execute as @e[tag=battle_member,distance=..64] if score @s test.battle.id = #battle_end test.battle.id unless score @s test.status.hp matches ..0 run function test:battle/return_member

# エリアを解放
execute if score #battle_end test.battle.arena matches 1 run scoreboard players set #arena_1 test.arena.occupied 0
execute if score #battle_end test.battle.arena matches 2 run scoreboard players set #arena_2 test.arena.occupied 0
execute if score #battle_end test.battle.arena matches 3 run scoreboard players set #arena_3 test.arena.occupied 0
execute if score #battle_end test.battle.arena matches 4 run scoreboard players set #arena_4 test.arena.occupied 0

# マーカーを掃除(エリア側)
kill @e[tag=battle_marker,distance=..64]
# マーカーを掃除(入り口側。ターン制マップに残っている)
execute in test:turn as @e[tag=battle_entrance] if score @s test.battle.id = #battle_end test.battle.id run kill @s