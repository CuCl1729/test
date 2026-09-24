#> test:job/station/populate_tree
# @s = Jobステーション本体。data.job_ui.jobで指定された職業のスキルツリーを表示する
# (現状は数個程度を想定しページングは未実装)

execute as @p[distance=..6] run function #oh_my_dat:please

data remove block ~ ~ ~ Items[{Slot:0b}]
data remove block ~ ~ ~ Items[{Slot:1b}]
data remove block ~ ~ ~ Items[{Slot:2b}]
data remove block ~ ~ ~ Items[{Slot:3b}]
data remove block ~ ~ ~ Items[{Slot:4b}]
data remove block ~ ~ ~ Items[{Slot:5b}]
data remove block ~ ~ ~ Items[{Slot:6b}]
data remove block ~ ~ ~ Items[{Slot:8b}]

data modify block ~ ~ ~ Items append value {Slot:8b,id:"barrier",count:1,components:{"minecraft:custom_name":{text:"戻る",italic:false},"minecraft:custom_data":{test:{job_ui:1b}}}}

data modify entity @s data.job_ui.node_ids set value []

data modify storage test: registry_work.tree_job set value {id:""}
data modify storage test: registry_work.tree_job.id set from entity @s data.job_ui.job

function test:job/station/populate_tree_load with storage test: registry_work.tree_job
