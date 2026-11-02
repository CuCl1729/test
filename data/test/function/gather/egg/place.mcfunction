#> test:gather/egg/place
# @s = 採取ポイントのエッグを使ったプレイヤー(test:trigger/place から)。実行位置はエッグで出たアマスタ。@macro egg: 採取物のid。
# そのブロック(エッグを使った面の手前)を新しいポイント p<n> としてワールドの記録(gather_world)に足し、すぐ置く。
# もう片方のマップは、読み込まれたときに test:gather/place/all が置く
execute as @n[type=armor_stand,tag=summoned,tag=gather_egg] at @s align xyz run tp @s ~ ~ ~
data modify storage test: gather_work.new set value {}
$data modify storage test: gather_work.new.type set value "$(egg)"
execute store result storage test: gather_work.new.x int 1 run data get entity @n[type=armor_stand,tag=summoned,tag=gather_egg] Pos[0]
execute store result storage test: gather_work.new.y int 1 run data get entity @n[type=armor_stand,tag=summoned,tag=gather_egg] Pos[1]
execute store result storage test: gather_work.new.z int 1 run data get entity @n[type=armor_stand,tag=summoned,tag=gather_egg] Pos[2]
kill @n[type=armor_stand,tag=summoned,tag=gather_egg]

$execute unless data storage test: asset.gather.$(egg) run return run tellraw @s {text:"採取物「$(egg)」は無い",color:"gray"}
execute unless dimension test:action unless dimension test:turn run return run tellraw @s {text:"test:action か test:turn で置く",color:"gray"}
execute align xyz positioned ~0.5 ~ ~0.5 if entity @e[type=interaction,tag=gather_point,distance=..0.5] run return run tellraw @s {text:"もう置いてある",color:"gray"}

scoreboard players add #gather_next test.time 1
execute store result storage test: gather_work.new.n int 1 run scoreboard players get #gather_next test.time
function test:gather/egg/add with storage test: gather_work.new
