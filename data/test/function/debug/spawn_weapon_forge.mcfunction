#> test:debug/spawn_weapon_forge
# 実行位置に鍛冶場（新規武器生成ステーション）を設置する

execute align xyz positioned ~0.5 ~0.5 ~0.5 run summon armor_stand ~ ~ ~ {Tags:["weapon_forge","summoned"],Invulnerable:1b,Invisible:0b,Marker:1b}
execute as @n[tag=summoned,tag=weapon_forge] at @s run function test:craft/weapon/forge/place
