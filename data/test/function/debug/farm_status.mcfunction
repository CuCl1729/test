#> test:debug/farm_status
# @s = プレイヤー。16ブロック以内の魔法作物の種類・段階・育ちきるまでの秒数を出す

tag @s add debug_farm_viewer
execute store result score #farm_now test.temporary run time query gametime
tellraw @s {text:"― 近くの魔法作物 ―",color:"gold"}
execute at @s as @e[type=interaction,tag=magic_crop,distance=..16,sort=nearest] run function test:debug/farm_status_line with entity @s data.crop
tag @s remove debug_farm_viewer
