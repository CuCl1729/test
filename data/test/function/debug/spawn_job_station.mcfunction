#> test:debug/spawn_job_station
# 実行位置にJobステーションを設置する

summon armor_stand ~ ~ ~ {Tags:["job_station","summoned"],Invulnerable:1b,Invisible:0b,Marker:1b}
execute as @n[tag=summoned,tag=job_station] at @s run function test:job/station/place
