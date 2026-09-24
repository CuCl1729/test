#> test:job/station/populate_list
# @s = Jobステーション本体。asset.job.jobsを舐めて解放済み/解放可能/未解放を出し分ける
# (現状は数個程度を想定しページングは未実装。増える場合はcraft/magic/research/populate_top系と
# 同じ矢印ページングを移植する)

execute as @p[distance=..6] run function #oh_my_dat:please

data modify storage test: registry_work.reverse_src set from storage test: asset.job.jobs
data remove storage test: registry_work.reverse_dst
function test:magic/registry/reverse_loop
data modify storage test: registry_work.job_queue set from storage test: registry_work.reverse_dst

data remove block ~ ~ ~ Items[{Slot:0b}]
data remove block ~ ~ ~ Items[{Slot:1b}]
data remove block ~ ~ ~ Items[{Slot:2b}]
data remove block ~ ~ ~ Items[{Slot:3b}]
data remove block ~ ~ ~ Items[{Slot:4b}]
data remove block ~ ~ ~ Items[{Slot:5b}]
data remove block ~ ~ ~ Items[{Slot:6b}]

data modify entity @s data.job_ui.page_ids set value []
scoreboard players set #job_slot test.temporary 0
function test:job/station/populate_list_loop
