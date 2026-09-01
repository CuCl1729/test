#> test:buff/apply_queue_loop
# buff_work.queue を末尾から取り出して1件ずつ付与する

execute unless data storage test: buff_work.queue[-1] run return 0

data modify storage test: buff_work.queue_entry set from storage test: buff_work.queue[-1]
data remove storage test: buff_work.queue[-1]

function test:buff/apply_queue_entry with storage test: buff_work.queue_entry

function test:buff/apply_queue_loop
