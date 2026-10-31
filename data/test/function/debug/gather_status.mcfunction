#> test:debug/gather_status
# @s = プレイヤー。16ブロック以内の採取ポイントの種類と、復活までの秒数を出す

tag @s add debug_gather_viewer
execute store result score #gather_now test.temporary run time query gametime
tellraw @s {text:"― 近くの採取ポイント ―",color:"gold"}
execute at @s as @e[type=interaction,tag=gather_point,distance=..16,sort=nearest] run function test:debug/gather_status_line with entity @s data.gather
tag @s remove debug_gather_viewer
