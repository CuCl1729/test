#> test:battle/ui/item_check
# skillだけは右クリックで処理しない。メインハンドに持っているだけでtest:battle/ui/skill_hover_tick
# (毎tick実行)がトロッコを出す。右クリックも処理してしまうと、トロッコを開く操作と
# アイテム本体の右クリックが競合してしまうため

execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".test{battle_action:"attack"} run function test:battle/ui/item_select {action:"attack"}
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".test{battle_action:"item"} run function test:battle/ui/item_select {action:"item"}
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".test{battle_action:"defend"} run function test:battle/ui/item_select {action:"defend"}