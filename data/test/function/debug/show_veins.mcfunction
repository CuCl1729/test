#> test:debug/show_veins
# @s = プレイヤー。@macro visible: 1b(表示)/ 0b(隠す)。64ブロック以内の鉱脈のアマスタの名前(鉱脈のid)を出し入れする

$execute at @s as @e[type=armor_stand,tag=mine_vein,distance=..64] run data modify entity @s CustomNameVisible set value $(visible)
