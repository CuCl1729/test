#> test:magic/periodic/self_spawn
# @s = 持ち主。持ち主に付いて回る発生源を置く。一定間隔で、持ち主の今の位置から次の段を起こす。
# つなぎの数値は chain_work.peek(呼び出し元が magic.player.chain[0] から取ってある)
execute unless function test:magic/root/can_spawn run return 0
execute unless function test:magic/root/commit run return 0

scoreboard players operation #emit_owner test.temporary = @s OhMyDatID

summon armor_stand ~ ~ ~ {Tags:["magic_emitter","emitter_new"],Marker:1b,Invisible:1b,NoGravity:1b,Invulnerable:1b,Small:1b}

data modify entity @n[type=armor_stand,tag=emitter_new] data.chain set from storage test: magic.player.chain
data modify entity @n[type=armor_stand,tag=emitter_new] data.uid set from storage test: magic.player.uid
data modify entity @n[type=armor_stand,tag=emitter_new] data.cast set from storage test: magic.player.cast
execute if data storage test: magic.player.data.action run data modify entity @n[type=armor_stand,tag=emitter_new] data.action set from storage test: magic.player.data.action
data modify entity @n[type=armor_stand,tag=emitter_new] data.periodic.behavior set from storage test: chain_work.peek.link_behavior
function test:magic/periodic/interval with storage test: chain_work.peek.link_params
execute store result entity @n[type=armor_stand,tag=emitter_new] data.periodic.interval_ticks int 1 run scoreboard players get #periodic_result test.temporary
execute store result score @n[type=armor_stand,tag=emitter_new] test.device.timer run scoreboard players get #periodic_result test.temporary

scoreboard players operation @n[type=armor_stand,tag=emitter_new] test.owner = #emit_owner test.temporary
execute store result score @n[type=armor_stand,tag=emitter_new] test.periodic.count run data get storage test: chain_work.peek.link_params.count

execute if data storage test: magic.player.root as @n[type=armor_stand,tag=emitter_new] run function test:magic/root/retain with storage test: magic.player.root
tag @n[type=armor_stand,tag=emitter_new] remove emitter_new
