#> test:battle/ui/item_check
# skillだけは右クリックで処理しない。メインハンドに持っているだけでtest:battle/ui/skill_hover_tick
# (毎tick実行)がトロッコを出す。右クリックも処理してしまうと、トロッコを開く操作と
# アイテム本体の右クリックが競合してしまうため
# attackも、敵が2体以上いる場合は同様に右クリックでは処理しない。事前召喚済みの対象選択トロッコ
# (test:battle/ui/attack_hover_show)側で選ばせるため。敵が1体以下の場合のみ、これまで通り
# 右クリックで即座に攻撃を確定する

scoreboard players set #enemy_count test.temporary 0
execute as @e[tag=battle_member,tag=enemy,distance=..64,scores={test.status.hp=1..}] run scoreboard players add #enemy_count test.temporary 1

execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".test{battle_action:"attack"} if score #enemy_count test.temporary matches ..1 run function test:battle/ui/item_select {action:"attack"}
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".test{battle_action:"item"} run function test:battle/ui/item_select {action:"item"}
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".test{battle_action:"defend"} run function test:battle/ui/item_select {action:"defend"}