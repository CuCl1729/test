#> test:debug/spawn_vein
# @s = プレイヤー。@macro id: 鉱脈のid。足元のブロックの角に、鉱脈のアマスタを置く(今いるマップだけ。
# test:action と test:turn の両方に、同じ位置で置く)。アマスタの位置が、鉱脈の構造物を置く角になる。
# 鉱山の範囲の中に置くと、その鉱山のリセットで鉱脈が置き直される

$execute unless data storage test: asset.vein.$(id) run return run tellraw @s [{text:"鉱脈「$(id)」はありません",color:gray}]
$execute at @s align xyz run summon armor_stand ~ ~ ~ {Tags:["mine_vein"],Marker:1b,Invisible:1b,NoGravity:1b,Invulnerable:1b,CustomName:{text:"$(id)",color:"gold"},CustomNameVisible:0b,data:{vein:"$(id)"}}
$tellraw @s [{text:"鉱脈を置いた: $(id)",color:gray}]
