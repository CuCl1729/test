#> test:craft/magic/research/craft
# @s = 研究ステーションのマーカー。近くのプレイヤーがスキルポイントを持っていれば、
# スロット9の素材に対応する魔法要素を習得させる（ポイント不足・習得済みの場合は素材を消費しない）

scoreboard players set #newly_learned test.temporary 0

execute if score @p[distance=..6] test.status.skill_point matches 1.. at @s as @p[distance=..6] run function test:craft/magic/research/apply
execute if score #newly_learned test.temporary matches 1 run data remove block ~ ~ ~ Items[{Slot:9b}]
execute unless score @p[distance=..6] test.status.skill_point matches 1.. run tellraw @p[distance=..6] [{text:"スキルポイントが足りません",color:red}]
