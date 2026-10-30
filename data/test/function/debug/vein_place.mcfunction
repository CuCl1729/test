#> test:debug/vein_place
# @macro dim/x/y/z/id: マップ(action / turn)、ブロックの座標、鉱脈のid。そのマップのその座標(ブロックの角)に鉱脈のアマスタを置く。
# 同じ位置に違う鉱脈のアマスタがあれば消して置き換え、同じ鉱脈のものがあればそのままにする(二重に置かない)

$execute in test:$(dim) positioned $(x) $(y) $(z) align xyz run kill @e[type=armor_stand,tag=mine_vein,distance=..0.5,nbt=!{data:{vein:"$(id)"}}]
$execute in test:$(dim) positioned $(x) $(y) $(z) align xyz unless entity @e[type=armor_stand,tag=mine_vein,distance=..0.5] run summon armor_stand ~ ~ ~ {Tags:["mine_vein"],Marker:1b,Invisible:1b,NoGravity:1b,Invulnerable:1b,CustomName:{text:"$(id)",color:"gold"},CustomNameVisible:0b,data:{vein:"$(id)"}}
