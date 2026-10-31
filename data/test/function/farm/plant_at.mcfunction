#> test:farm/plant_at
# @s = プレイヤー。実行位置 = 視線が当たったブロック。耕地で、その1つ上が空気で、まだ魔法作物が無ければ植える

execute unless block ~ ~ ~ minecraft:farmland run return run title @s actionbar {text:"耕地に植える",color:"gray"}
execute align xyz positioned ~0.5 ~1 ~0.5 unless block ~ ~ ~ #minecraft:air run return run title @s actionbar {text:"上が空いていない",color:"gray"}
execute align xyz positioned ~0.5 ~1 ~0.5 if entity @e[type=interaction,tag=magic_crop,distance=..0.5] run return 0
execute align xyz positioned ~0.5 ~1 ~0.5 run function test:farm/plant_here with storage test: farm_work.seed
