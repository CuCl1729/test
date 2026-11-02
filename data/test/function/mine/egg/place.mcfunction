#> test:mine/egg/place
# @s = 鉱脈のエッグを使ったプレイヤー(test:trigger/place から)。実行位置はエッグで出たアマスタ。@macro egg: 鉱脈のid。
# その位置のブロックの角に、両マップで鉱脈を置く(test:debug/vein_put。そこに立って [足元に設置] したのと同じ位置)
execute as @n[type=armor_stand,tag=summoned,tag=vein_egg] at @s align xyz run tp @s ~ ~ ~
data modify storage test: debug_work.vein_at set value {}
execute store result storage test: debug_work.vein_at.x int 1 run data get entity @n[type=armor_stand,tag=summoned,tag=vein_egg] Pos[0]
execute store result storage test: debug_work.vein_at.y int 1 run data get entity @n[type=armor_stand,tag=summoned,tag=vein_egg] Pos[1]
execute store result storage test: debug_work.vein_at.z int 1 run data get entity @n[type=armor_stand,tag=summoned,tag=vein_egg] Pos[2]
kill @n[type=armor_stand,tag=summoned,tag=vein_egg]

$execute unless data storage test: asset.vein.$(egg) run return run tellraw @s [{text:"鉱脈「$(egg)」はありません",color:gray}]
$function test:debug/vein_put {id:"$(egg)"}
