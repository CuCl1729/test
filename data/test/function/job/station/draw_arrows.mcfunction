#> test:job/station/draw_arrows
# @s = Jobステーション本体。#job_more test.temporary = 続きがあれば1。前/次のページの矢印をスロット0/8に置き、
# data.job_ui.has_next を合わせる(test:job/station/populate_list・populate_tree の最後に呼ぶ)

data modify entity @s data.job_ui.has_next set value 0b
execute unless entity @s[nbt={data:{job_ui:{page:0}}}] run data modify block ~ ~ ~ Items append value {Slot:0b,id:"arrow",count:1,components:{"minecraft:custom_name":{text:"◀ 前のページ",italic:false},"minecraft:custom_data":{test:{job_ui:1b}}}}
execute if score #job_more test.temporary matches 1 run data modify entity @s data.job_ui.has_next set value 1b
execute if score #job_more test.temporary matches 1 run data modify block ~ ~ ~ Items append value {Slot:8b,id:"arrow",count:1,components:{"minecraft:custom_name":{text:"次のページ ▶",italic:false},"minecraft:custom_data":{test:{job_ui:1b}}}}
