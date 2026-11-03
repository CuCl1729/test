#> test:magic/place/recast
# @s = 詠唱者。magic.player.uid の魔法の、自分が置いた「再使用で」の設置物があれば起動して 1 を返す(無ければ 0)
scoreboard players set #recast_fired test.temporary 0
scoreboard players operation #recast_owner test.temporary = @s OhMyDatID
execute store result score #recast_uid test.temporary run data get storage test: magic.player.uid
execute as @e[type=armor_stand,tag=magic_device,tag=device_recast] if score @s test.owner = #recast_owner test.temporary if score @s test.magic_uid = #recast_uid test.temporary run tag @s add device_recast_hit
execute as @e[type=armor_stand,tag=device_recast_hit] run scoreboard players set #recast_fired test.temporary 1
execute as @e[type=armor_stand,tag=device_recast_hit] at @s run function test:magic/place/fire
return run scoreboard players get #recast_fired test.temporary
