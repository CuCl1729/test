#> test:battle/enter_arena
# @s = 参加者。呼び出し元で in test:arena 済み。$(x)(y)(z) = エリア座標

$teleport @s $(x) $(y) $(z)

scoreboard players add @e[tag=battle_marker,sort=nearest,limit=1] test.battle.member_count 1
scoreboard players operation @s test.battle.turn_order = @e[tag=battle_marker,sort=nearest,limit=1] test.battle.member_count

tag @s add battle_member