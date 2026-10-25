#> test:equip/effect/magic_damage_up
# event: magic_cast。@s = 詠唱者。@macro type/percent: 詠唱する魔法(storage test: magic.player)のタイプに
# typeが含まれていれば(例: projectile)、詠唱者の属性ダメージをpercent%上げる

$execute unless data storage test: magic.player{types:["$(type)"]} run return 0

$scoreboard players set #equip_pct test.temporary $(percent)
scoreboard players add #equip_pct test.temporary 100

scoreboard players operation @s test.fire_damage *= #equip_pct test.temporary
scoreboard players operation @s test.fire_damage /= #100 test.constant
scoreboard players operation @s test.water_damage *= #equip_pct test.temporary
scoreboard players operation @s test.water_damage /= #100 test.constant
scoreboard players operation @s test.wood_damage *= #equip_pct test.temporary
scoreboard players operation @s test.wood_damage /= #100 test.constant
scoreboard players operation @s test.metal_damage *= #equip_pct test.temporary
scoreboard players operation @s test.metal_damage /= #100 test.constant
scoreboard players operation @s test.earth_damage *= #equip_pct test.temporary
scoreboard players operation @s test.earth_damage /= #100 test.constant
