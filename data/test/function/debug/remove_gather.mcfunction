#> test:debug/remove_gather
# @s = プレイヤー。3ブロック以内でいちばん近い採取ポイントを、両マップから消す(test:gather/egg/remove)
execute unless entity @e[type=interaction,tag=gather_point,distance=..3] run return run tellraw @s {text:"近くに採取ポイントが無い",color:"gray"}
tellraw @s [{text:"採取ポイントを消した: ",color:"gray"},{entity:"@n[type=interaction,tag=gather_point,distance=..3]",nbt:"data.gather.point",interpret:true,color:"white"}]
execute as @n[type=interaction,tag=gather_point,distance=..3] run function test:gather/egg/remove with entity @s data.gather
