#> test:battle/enter_arena
# @s = 参加者。呼び出し元で in test:arena 済み。$(x)(y)(z) = エリア座標
execute store result score @s test.battle.return_x run data get entity @s Pos[0] 1
execute store result score @s test.battle.return_y run data get entity @s Pos[1] 1
execute store result score @s test.battle.return_z run data get entity @s Pos[2] 1

$teleport @s $(x) $(y) $(z)

# 参加者の数と手番の順番は、同じ戦闘IDのマーカーで数える(実行位置はフィールドの座標のままなので、
# 「一番近いマーカー」だと戦闘が複数あるときに別の戦闘のものを数えてしまう)
scoreboard players operation #enter_battle test.battle.id = @s test.battle.id
execute as @e[tag=battle_marker] if score @s test.battle.id = #enter_battle test.battle.id run scoreboard players add @s test.battle.member_count 1
execute as @e[tag=battle_marker] if score @s test.battle.id = #enter_battle test.battle.id run scoreboard players operation #enter_battle test.battle.member_count = @s test.battle.member_count
scoreboard players operation @s test.battle.turn_order = #enter_battle test.battle.member_count
