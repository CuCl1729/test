#> test:battle/ui/target_toggle
# @s = クリック/選択された対象(1体)。test.battle.target_maxが1ならラジオボタン式(既存の選択を解除してから付け直す)、
# 2以上なら単純トグル(複数選択可、将来の多段ヒット魔法用)

execute store success score #was_selected test.temporary if entity @s[tag=battle_target]

execute if score #was_selected test.temporary matches 1 run tag @s remove battle_target
execute if score #was_selected test.temporary matches 0 if score @p[distance=..64] test.battle.target_max matches 1 run tag @e[tag=battle_target] remove battle_target
execute if score #was_selected test.temporary matches 0 run tag @s add battle_target
