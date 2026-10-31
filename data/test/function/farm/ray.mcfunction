#> test:farm/ray
# @s = プレイヤー。実行位置を視線の先へ 0.1 ずつ進め、空気でないブロックに当たったら test:farm/plant_at を呼ぶ

execute unless block ~ ~ ~ #minecraft:air run return run function test:farm/plant_at
scoreboard players remove #farm_ray test.temporary 1
execute if score #farm_ray test.temporary matches ..0 run return run title @s actionbar {text:"耕地に植える",color:"gray"}
execute positioned ^ ^ ^0.1 run function test:farm/ray
