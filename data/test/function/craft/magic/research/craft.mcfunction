#> test:craft/magic/research/craft
# @s = 研究ステーションのマーカー。近くのプレイヤーがスキルポイントを持っていれば、
# スロット9の素材に対応する魔法要素を習得させる（ポイントが無ければ何もしない）

execute if score @p[distance=..6] test.status.skill_point matches 1.. at @s as @p[distance=..6] run function test:craft/magic/research/apply
execute if score @p[distance=..6] test.status.skill_point matches 1.. run data remove block ~ ~ ~ Items[{Slot:9b}]
