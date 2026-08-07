#> test:magic/crafter/success
# @s = クラフター本体（アーマースタンド）。魔法作成成功時の演出

playsound minecraft:entity.player.levelup master @a[distance=..6] ~ ~ ~ 1 1.4
particle minecraft:end_rod ~ ~1 ~ 0.4 0.5 0.4 0.02 40 force
particle minecraft:totem_of_undying ~ ~1 ~ 0.4 0.5 0.4 0.3 20 force

tellraw @a[distance=..6] [{text:"魔法の作成に成功した！",color:gold}]
