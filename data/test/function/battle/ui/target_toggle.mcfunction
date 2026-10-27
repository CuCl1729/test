#> test:battle/ui/target_toggle
# @s = クリック/選択された対象(1体)。手番の人のtest.battle.target_max(呼び出し元が #target_max に控える)が
# 1ならラジオボタン式(既存の選択を解除してから付け直す)、2以上なら単純トグル(複数選択可、将来の多段ヒット魔法用)

execute store success score #was_selected test.temporary if entity @s[tag=battle_target]

execute if score #was_selected test.temporary matches 1 run tag @s remove battle_target
# 解除するのは同じ戦闘の選択だけ(@sの敵も手番の人と同じ戦闘IDを持つ)
execute if score #was_selected test.temporary matches 0 if score #target_max test.battle.target_max matches 1 run function test:battle/target/clear
execute if score #was_selected test.temporary matches 0 run tag @s add battle_target
