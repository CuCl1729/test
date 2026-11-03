#> test:magic/aoe/blast_one
# @s = 吹き飛ばす相手。実行位置 = 爆発の中心。@macro power/lift: 外向き・上向きの速さ(0.01 ブロック/tick)。
# 中心から相手の足元への向き × power に、上向き lift を足した速度を与える。中心から 0.5 以内なら真上(power + lift)だけ。
# プレイヤーはエンチャントの apply_impulse(test:motion/player/push)、ほかは Motion で与える
scoreboard players set #motion test.X0 0
scoreboard players set #motion test.Z0 0
$scoreboard players set #motion test.Y0 $(lift)
$scoreboard players set #blast_power test.temporary $(power)
execute if entity @s[distance=..0.5] run scoreboard players operation #motion test.Y0 += #blast_power test.temporary
execute unless entity @s[distance=..0.5] run function test:magic/aoe/blast_dir

execute if entity @s[type=player] run function test:motion/player/push
execute unless entity @s[type=player] store result entity @s Motion[0] double 0.01 run scoreboard players get #motion test.X0
execute unless entity @s[type=player] store result entity @s Motion[1] double 0.01 run scoreboard players get #motion test.Y0
execute unless entity @s[type=player] store result entity @s Motion[2] double 0.01 run scoreboard players get #motion test.Z0
