#> test:job/station/populate_list
# @s = Jobステーション本体。asset.job.jobsを舐めて解放済み/解放可能/未解放を出し分ける。
# data.job_ui.page 件を読み飛ばして7件をスロット1〜7に並べ、前/次のページの矢印をスロット0/8に置く

execute as @p[distance=..6] run function #oh_my_dat:please

data modify storage test: registry_work.reverse_src set from storage test: asset.job.jobs
data remove storage test: registry_work.reverse_dst
function test:magic/registry/reverse_loop
data modify storage test: registry_work.job_queue set from storage test: registry_work.reverse_dst

scoreboard players set #job_skip test.temporary 0
execute store result score #job_skip test.temporary run data get entity @s data.job_ui.page
function test:job/station/skip_list

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

data modify entity @s data.job_ui.page_ids set value []
scoreboard players set #job_slot test.temporary 1
function test:job/station/populate_list_loop

scoreboard players set #job_more test.temporary 0
execute if data storage test: registry_work.job_queue[-1] run scoreboard players set #job_more test.temporary 1
function test:job/station/draw_arrows
