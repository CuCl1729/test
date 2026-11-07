#> test:job/station/populate_tree
# @s = Jobステーション本体。data.job_ui.jobで指定された職業のスキルツリーを表示する。
# data.job_ui.page 件を読み飛ばして7件をスロット1〜7に並べ、矢印をスロット0/8、戻るをスロット18に置く

data modify entity @s data.station.buttons set value {}
execute as @p[distance=..6] run function #oh_my_dat:please

data remove block ~ ~ ~ Items[{Slot:0b}]
data remove block ~ ~ ~ Items[{Slot:1b}]
data remove block ~ ~ ~ Items[{Slot:2b}]
data remove block ~ ~ ~ Items[{Slot:3b}]
data remove block ~ ~ ~ Items[{Slot:4b}]
data remove block ~ ~ ~ Items[{Slot:5b}]
data remove block ~ ~ ~ Items[{Slot:6b}]
data remove block ~ ~ ~ Items[{Slot:7b}]
data remove block ~ ~ ~ Items[{Slot:8b}]
data remove block ~ ~ ~ Items[{Slot:18b}]

data modify block ~ ~ ~ Items append value {Slot:18b,id:"barrier",count:1,components:{"minecraft:custom_name":{text:"戻る",italic:false},"minecraft:custom_data":{test:{job_ui:1b}}}}

# スキルのリセット(押した本人に確認を出す。test:job/station/click_reset)
data remove block ~ ~ ~ Items[{Slot:26b}]
data modify storage test: job_work.reset_item set value {Slot:26b,id:"tnt",count:1,components:{"minecraft:custom_name":{text:"スキルをリセット",color:"red",italic:false},"minecraft:custom_data":{test:{job_ui:1b}}}}
function test:station/action/stamp {item:"job_work.reset_item",slot:26}
data modify block ~ ~ ~ Items append from storage test: job_work.reset_item

data modify entity @s data.job_ui.node_ids set value []

data modify storage test: registry_work.tree_job set value {id:""}
data modify storage test: registry_work.tree_job.id set from entity @s data.job_ui.job

function test:job/station/populate_tree_load with storage test: registry_work.tree_job

scoreboard players set #job_more test.temporary 0
execute if data storage test: registry_work.tree_queue[-1] run scoreboard players set #job_more test.temporary 1
function test:job/station/draw_arrows
