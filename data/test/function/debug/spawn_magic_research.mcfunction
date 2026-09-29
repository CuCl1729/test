#> test:debug/spawn_magic_research
# 実行位置に魔法要素の研究ステーションを設置する

execute align xyz positioned ~0.5 ~0.5 ~0.5 run summon armor_stand ~ ~ ~ {Tags:["magic_research","summoned"],Invulnerable:1b,Invisible:0b,Marker:1b}
execute as @n[tag=summoned,tag=magic_research] at @s run function test:craft/magic/research/place
