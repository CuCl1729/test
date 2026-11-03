#> test:magic/place/ray
# @s = 詠唱者。実行位置 = 視線上の点。0.25 ブロックずつ進み、空気でないブロックに入ったら一歩戻った所に置く(20歩 = 5ブロックまで)
execute unless block ~ ~ ~ #minecraft:air positioned ^ ^ ^-0.25 run return run function test:magic/place/ray_hit
scoreboard players add #place_step test.temporary 1
execute if score #place_step test.temporary matches 20.. run return 0
execute positioned ^ ^ ^0.25 run function test:magic/place/ray
