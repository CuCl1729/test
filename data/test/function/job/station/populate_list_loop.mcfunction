#> test:job/station/populate_list_loop
# @s = Jobステーション本体(please実行済み)。registry_work.job_queueを末尾から詰める

execute unless data storage test: registry_work.job_queue[-1] run return 0
execute if score #job_slot test.temporary matches 7.. run return 0

data modify storage test: registry_work.job_entry set from storage test: registry_work.job_queue[-1]
data remove storage test: registry_work.job_queue[-1]

execute store result storage test: registry_work.job_entry.slot int 1 run scoreboard players get #job_slot test.temporary
function test:job/station/populate_list_slot with storage test: registry_work.job_entry

scoreboard players add #job_slot test.temporary 1
function test:job/station/populate_list_loop
