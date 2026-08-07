#> test:magic/crafter/failure
# @s = クラフター本体（アーマースタンド）。魔法作成失敗時の演出

playsound minecraft:block.barrel.close master @a[distance=..6] ~ ~ ~ 1 0.6

tellraw @a[distance=..6] [{text:"魔法の作成に失敗した…素材を確認してください",color:gray}]
