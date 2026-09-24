#> test:job/station/main_tree
# @s = Jobステーション本体。ツリービューでのクリック検知(スロット0〜6 ↔ data.job_ui.node_ids[0]〜[6]、
# スロット8=戻る)

execute if data entity @s data.job_ui.node_ids[0] unless data block ~ ~ ~ Items[{Slot:0b}] run function test:job/station/click_tree {index:0}
execute if data entity @s data.job_ui.node_ids[1] unless data block ~ ~ ~ Items[{Slot:1b}] run function test:job/station/click_tree {index:1}
execute if data entity @s data.job_ui.node_ids[2] unless data block ~ ~ ~ Items[{Slot:2b}] run function test:job/station/click_tree {index:2}
execute if data entity @s data.job_ui.node_ids[3] unless data block ~ ~ ~ Items[{Slot:3b}] run function test:job/station/click_tree {index:3}
execute if data entity @s data.job_ui.node_ids[4] unless data block ~ ~ ~ Items[{Slot:4b}] run function test:job/station/click_tree {index:4}
execute if data entity @s data.job_ui.node_ids[5] unless data block ~ ~ ~ Items[{Slot:5b}] run function test:job/station/click_tree {index:5}
execute if data entity @s data.job_ui.node_ids[6] unless data block ~ ~ ~ Items[{Slot:6b}] run function test:job/station/click_tree {index:6}
execute unless data block ~ ~ ~ Items[{Slot:8b}] run function test:job/station/click_back
