#> test:debug/spawn_equip_station
# 実行位置に防具工房(防具・アクセサリーを作るステーション)を設置する

execute align xyz positioned ~0.5 ~0.5 ~0.5 run summon armor_stand ~ ~ ~ {Tags:["equip_workshop","summoned"],Invulnerable:1b,Invisible:0b,Marker:1b}
execute as @n[tag=summoned,tag=equip_workshop] at @s run function test:craft/equip/place
