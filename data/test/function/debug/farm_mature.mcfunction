#> test:debug/farm_mature
# @s = プレイヤー。16ブロック以内の魔法作物を、すぐに育ちきった段階にする

execute at @s as @e[type=interaction,tag=magic_crop,distance=..16] run function test:debug/farm_mature_one with entity @s data.crop
