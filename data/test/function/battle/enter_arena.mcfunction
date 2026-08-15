#> test:battle/enter_arena
# @s = 参加者。呼び出し元で in test:arena 済み。$(x)(y)(z) = エリア座標
execute store result score @s test.battle.return_x run data get entity @s Pos[0] 1
execute store result score @s test.battle.return_y run data get entity @s Pos[1] 1
execute store result score @s test.battle.return_z run data get entity @s Pos[2] 1

$teleport @s $(x) $(y) $(z)

scoreboard players add @e[tag=battle_marker,sort=nearest,limit=1] test.battle.member_count 1
scoreboard players operation @s test.battle.turn_order = @e[tag=battle_marker,sort=nearest,limit=1] test.battle.member_count
