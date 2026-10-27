#> test:debug/spawn_station
# @macro id: ステーションの種類(init/asset/station の asset.station.<id>)。実行位置にそのステーションを設置する

$execute align xyz positioned ~0.5 ~0.5 ~0.5 run summon armor_stand ~ ~ ~ {Tags:["station","summoned"],Invulnerable:1b,Invisible:0b,Marker:1b,data:{station:{id:"$(id)",mode:0}}}
execute as @n[tag=summoned,tag=station] at @s run function test:station/place
