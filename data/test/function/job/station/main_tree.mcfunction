#> test:job/station/main_tree
# @s = Jobステーション本体。ツリービューでのクリック検知(スロット1〜7 ↔ data.job_ui.node_ids[0]〜[6]、
# スロット0/8 = 前/次のページ、スロット18 = 戻る、スロット26 = スキルをリセット)

execute unless entity @s[nbt={data:{job_ui:{page:0}}}] unless data block ~ ~ ~ Items[{Slot:0b}] run return run function test:job/station/click_arrow {dir:-1}
execute if entity @s[nbt={data:{job_ui:{has_next:1b}}}] unless data block ~ ~ ~ Items[{Slot:8b}] run return run function test:job/station/click_arrow {dir:1}
execute unless data block ~ ~ ~ Items[{Slot:18b}] run return run function test:job/station/click_back
execute unless data block ~ ~ ~ Items[{Slot:26b}] run return run function test:job/station/click_reset

execute if data entity @s data.job_ui.node_ids[0] unless data block ~ ~ ~ Items[{Slot:1b}] run return run function test:job/station/click_tree {index:0,slot:1}
execute if data entity @s data.job_ui.node_ids[1] unless data block ~ ~ ~ Items[{Slot:2b}] run return run function test:job/station/click_tree {index:1,slot:2}
execute if data entity @s data.job_ui.node_ids[2] unless data block ~ ~ ~ Items[{Slot:3b}] run return run function test:job/station/click_tree {index:2,slot:3}
execute if data entity @s data.job_ui.node_ids[3] unless data block ~ ~ ~ Items[{Slot:4b}] run return run function test:job/station/click_tree {index:3,slot:4}
execute if data entity @s data.job_ui.node_ids[4] unless data block ~ ~ ~ Items[{Slot:5b}] run return run function test:job/station/click_tree {index:4,slot:5}
execute if data entity @s data.job_ui.node_ids[5] unless data block ~ ~ ~ Items[{Slot:6b}] run return run function test:job/station/click_tree {index:5,slot:6}
execute if data entity @s data.job_ui.node_ids[6] unless data block ~ ~ ~ Items[{Slot:7b}] run return run function test:job/station/click_tree {index:6,slot:7}
