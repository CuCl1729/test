#> test:magic/place/put
# @s = 持ち主のプレイヤー。実行位置 = 置く所。magic.player = 設置の段(chain[0] が起動の条件のつなぎ、uid が魔法の通し番号)。
# 設置物は見えないアーマースタンド(頭にロードストーン)。それ自体は効果を持たず、起動すると次の段を始める
# (test:magic/place/fire)。同じ持ち主・同じ魔法の設置物は、唱えた回(cast)ごとに残る。次の回に置くと、
# 前の回のものは消える(複数発射した弾がそれぞれ置いた分は、同じ回なので全部残る)
execute unless function test:magic/root/can_spawn run return 0
execute unless function test:magic/root/commit run return 0

scoreboard players operation #place_owner test.temporary = @s OhMyDatID
scoreboard players set #place_uid test.temporary 0
execute store result score #place_uid test.temporary run data get storage test: magic.player.uid
scoreboard players set #place_cast test.temporary 0
execute store result score #place_cast test.temporary run data get storage test: magic.player.cast
execute as @e[type=armor_stand,tag=magic_device] if score @s test.owner = #place_owner test.temporary if score @s test.magic_uid = #place_uid test.temporary unless score @s test.magic_cast = #place_cast test.temporary run function test:magic/root/kill

summon armor_stand ~ ~ ~ {Tags:["magic_device","device_new"],Marker:1b,Invisible:1b,NoGravity:1b,Invulnerable:1b,Small:1b,equipment:{head:{id:"minecraft:lodestone",count:1}}}
data modify entity @n[type=armor_stand,tag=device_new] data.chain set from storage test: magic.player.chain
data modify entity @n[type=armor_stand,tag=device_new] data.uid set from storage test: magic.player.uid
execute if data storage test: magic.player.data.action run data modify entity @n[type=armor_stand,tag=device_new] data.action set from storage test: magic.player.data.action
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

# 一定間隔: 設置物が消えずに、間隔ごとに次の段を繰り返し始める(砲台)。
# 何をするかは組み合わせの表が選んだ behavior、回数と間隔はつなぎの数値
execute if data storage test: chain_work{peek:{link:"periodic"}} run tag @n[type=armor_stand,tag=device_new] add device_periodic
execute if data storage test: chain_work{peek:{link:"periodic"}} run data modify entity @n[type=armor_stand,tag=device_new] data.periodic.behavior set from storage test: chain_work.peek.link_behavior
execute if data storage test: chain_work{peek:{link:"periodic"}} run function test:magic/periodic/interval with storage test: chain_work.peek.link_params
execute if data storage test: chain_work{peek:{link:"periodic"}} store result entity @n[type=armor_stand,tag=device_new] data.periodic.interval_ticks int 1 run scoreboard players get #periodic_result test.temporary
execute if data storage test: chain_work{peek:{link:"periodic"}} store result score @n[type=armor_stand,tag=device_new] test.device.timer run scoreboard players get #periodic_result test.temporary
execute if data storage test: chain_work{peek:{link:"periodic"}} store result score @n[type=armor_stand,tag=device_new] test.periodic.count run data get storage test: chain_work.peek.link_params.count

playsound minecraft:block.stone.place master @a ~ ~ ~ 1 1.2
execute if data storage test: magic.player.root as @n[type=armor_stand,tag=device_new] run function test:magic/root/retain with storage test: magic.player.root
tag @n[type=armor_stand,tag=device_new] remove device_new
