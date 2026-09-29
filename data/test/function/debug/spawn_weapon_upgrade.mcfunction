#> test:debug/spawn_weapon_upgrade
# 実行位置に強化炉（既存武器レベルアップステーション）を設置する

execute align xyz positioned ~0.5 ~0.5 ~0.5 run summon armor_stand ~ ~ ~ {Tags:["weapon_upgrade","summoned"],Invulnerable:1b,Invisible:0b,Marker:1b}
execute as @n[tag=summoned,tag=weapon_upgrade] at @s run function test:craft/weapon/upgrade/place
