#> test:magic/place/put
# @s = 持ち主のプレイヤー。実行位置 = 置く所。magic.player = 設置の段(chain[0] が起動の条件のつなぎ、uid が魔法の通し番号)。
# 設置物は見えないアーマースタンド(頭にロードストーン)。それ自体は効果を持たず、起動すると次の段を始める
# (test:magic/place/fire)。同じ持ち主・同じ魔法の設置物は、唱えた回(cast)ごとに残る。次の回に置くと、
# 前の回のものは消える(複数発射した弾がそれぞれ置いた分は、同じ回なので全部残る)
scoreboard players operation #place_owner test.temporary = @s OhMyDatID
scoreboard players set #place_uid test.temporary 0
execute store result score #place_uid test.temporary run data get storage test: magic.player.uid
scoreboard players set #place_cast test.temporary 0
execute store result score #place_cast test.temporary run data get storage test: magic.player.cast
execute as @e[type=armor_stand,tag=magic_device] if score @s test.owner = #place_owner test.temporary if score @s test.magic_uid = #place_uid test.temporary unless score @s test.magic_cast = #place_cast test.temporary run kill @s

summon armor_stand ~ ~ ~ {Tags:["magic_device","device_new"],Marker:1b,Invisible:1b,NoGravity:1b,Invulnerable:1b,Small:1b,equipment:{head:{id:"minecraft:lodestone",count:1}}}
data modify entity @n[type=armor_stand,tag=device_new] data.chain set from storage test: magic.player.chain
data modify entity @n[type=armor_stand,tag=device_new] data.uid set from storage test: magic.player.uid
scoreboard players operation @n[type=armor_stand,tag=device_new] test.owner = #place_owner test.temporary
scoreboard players operation @n[type=armor_stand,tag=device_new] test.magic_uid = #place_uid test.temporary
scoreboard players operation @n[type=armor_stand,tag=device_new] test.magic_cast = #place_cast test.temporary
execute store result score @n[type=armor_stand,tag=device_new] test.device.life run data get storage test: magic.player.place.life 20

# 起動の条件(次のつなぎ)
data remove storage test: chain_work.peek
data modify storage test: chain_work.peek set from storage test: magic.player.chain[0]
execute if data storage test: chain_work{peek:{link:"on_recast"}} run tag @n[type=armor_stand,tag=device_new] add device_recast
execute if data storage test: chain_work{peek:{link:"on_timer"}} run tag @n[type=armor_stand,tag=device_new] add device_timer
execute if data storage test: chain_work{peek:{link:"on_timer"}} store result score @n[type=armor_stand,tag=device_new] test.device.timer run data get storage test: chain_work.peek.link_params.seconds 20
execute if data storage test: chain_work{peek:{link:"on_touch"}} run tag @n[type=armor_stand,tag=device_new] add device_touch
execute if data storage test: chain_work{peek:{link:"on_touch"}} run data modify entity @n[type=armor_stand,tag=device_new] data.radius set from storage test: chain_work.peek.link_params.radius

playsound minecraft:block.stone.place master @a ~ ~ ~ 1 1.2
tag @n[type=armor_stand,tag=device_new] remove device_new
