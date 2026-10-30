#> test:debug/check_veins_one
# @s = 鉱脈のアマスタ。@macro dim/other: このアマスタのマップと、もう片方のマップ。
# 位置(ブロックの座標)と鉱脈のidを debug_work.check に入れて比べる

$data modify storage test: debug_work.check set value {dim:"$(dim)",other:"$(other)",vein:""}
data modify storage test: debug_work.check.vein set from entity @s data.vein
execute store result storage test: debug_work.check.x int 1 run data get entity @s Pos[0] 1
execute store result storage test: debug_work.check.y int 1 run data get entity @s Pos[1] 1
execute store result storage test: debug_work.check.z int 1 run data get entity @s Pos[2] 1
function test:debug/check_veins_pair with storage test: debug_work.check
