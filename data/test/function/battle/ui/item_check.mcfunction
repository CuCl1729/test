#> test:battle/ui/item_check

execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".test{battle_action:"attack"} run function test:battle/ui/item_select {action:"attack"}
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".test{battle_action:"skill"} run function test:battle/ui/item_select {action:"skill"}
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".test{battle_action:"item"} run function test:battle/ui/item_select {action:"item"}
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".test{battle_action:"defend"} run function test:battle/ui/item_select {action:"defend"}