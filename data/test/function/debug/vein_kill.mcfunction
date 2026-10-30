#> test:debug/vein_kill
# @macro dim/x/y/z/r: マップ(action / turn)、ブロックの座標、半径。そのマップで、その座標(ブロックの角)から
# 半径 r 以内の鉱脈のアマスタを消し、消した数を #vein_removed に足す

$execute store result score #vein_n test.temporary in test:$(dim) positioned $(x) $(y) $(z) align xyz if entity @e[type=armor_stand,tag=mine_vein,distance=..$(r)]
scoreboard players operation #vein_removed test.temporary += #vein_n test.temporary
$execute in test:$(dim) positioned $(x) $(y) $(z) align xyz run kill @e[type=armor_stand,tag=mine_vein,distance=..$(r)]
