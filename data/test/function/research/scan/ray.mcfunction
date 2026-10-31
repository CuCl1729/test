#> test:research/scan/ray
# @s = プレイヤー。実行位置 = 視線の上の点。当たり判定がこの点を含むエンティティ(プレイヤー・見た目だけのものは除く)、
# 無ければ空気でないブロックに当たったら止めて照合する。当たらなければ 0.1 進める(#scan_ray 回まで)

execute positioned ~-0.99 ~-0.99 ~-0.99 as @e[dx=0,type=!player,type=!marker,type=!item,type=!item_display,type=!block_display,type=!text_display,type=!experience_orb,type=!area_effect_cloud] positioned ~0.99 ~0.99 ~0.99 if entity @s[dx=0] run tag @s add scan_hit
execute if entity @e[tag=scan_hit,limit=1] run return run function test:research/scan/hit_entity
execute unless block ~ ~ ~ #minecraft:air run return run function test:research/scan/hit_block
scoreboard players remove #scan_ray test.temporary 1
execute if score #scan_ray test.temporary matches 1.. positioned ^ ^ ^0.1 run function test:research/scan/ray
