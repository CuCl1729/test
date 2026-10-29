#> test:job/station/main_list
# @s = Jobステーション本体。一覧ビューでのクリック検知(スロット1〜7 ↔ data.job_ui.page_ids[0]〜[6]、
# スロット0/8 = 前/次のページ。魔法台の研究と同じ形)

execute unless entity @s[nbt={data:{job_ui:{page:0}}}] unless data block ~ ~ ~ Items[{Slot:0b}] run return run function test:job/station/click_arrow {dir:-1}
execute if entity @s[nbt={data:{job_ui:{has_next:1b}}}] unless data block ~ ~ ~ Items[{Slot:8b}] run return run function test:job/station/click_arrow {dir:1}

execute if data entity @s data.job_ui.page_ids[0] unless data block ~ ~ ~ Items[{Slot:1b}] run return run function test:job/station/click_list {index:0}
execute if data entity @s data.job_ui.page_ids[1] unless data block ~ ~ ~ Items[{Slot:2b}] run return run function test:job/station/click_list {index:1}
execute if data entity @s data.job_ui.page_ids[2] unless data block ~ ~ ~ Items[{Slot:3b}] run return run function test:job/station/click_list {index:2}
execute if data entity @s data.job_ui.page_ids[3] unless data block ~ ~ ~ Items[{Slot:4b}] run return run function test:job/station/click_list {index:3}
execute if data entity @s data.job_ui.page_ids[4] unless data block ~ ~ ~ Items[{Slot:5b}] run return run function test:job/station/click_list {index:4}
execute if data entity @s data.job_ui.page_ids[5] unless data block ~ ~ ~ Items[{Slot:6b}] run return run function test:job/station/click_list {index:5}
execute if data entity @s data.job_ui.page_ids[6] unless data block ~ ~ ~ Items[{Slot:7b}] run return run function test:job/station/click_list {index:6}
