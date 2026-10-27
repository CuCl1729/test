#> test:debug/spawn_equip_magic_station
# 実行位置に魔法付与台(防具・アクセサリーの自動発動の枠に魔法を付けるステーション)を設置する

execute align xyz positioned ~0.5 ~0.5 ~0.5 run summon armor_stand ~ ~ ~ {Tags:["equip_magic_station","summoned"],Invulnerable:1b,Invisible:0b,Marker:1b}
execute as @n[tag=summoned,tag=equip_magic_station] at @s run function test:craft/equip_magic/place
