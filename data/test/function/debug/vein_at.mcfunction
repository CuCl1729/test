#> test:debug/vein_at
# @s = プレイヤー。足元のブロックの座標(整数)を debug_work.vein_at = {x, y, z} に入れる。
# 2つのマップに同じ座標で置くため、ディメンションを変えても座標がずれないよう数値で持つ

data modify storage test: debug_work.vein_at set value {}
execute store result storage test: debug_work.vein_at.x int 1 run data get entity @s Pos[0] 1
execute store result storage test: debug_work.vein_at.y int 1 run data get entity @s Pos[1] 1
execute store result storage test: debug_work.vein_at.z int 1 run data get entity @s Pos[2] 1
