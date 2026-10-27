#> test:equip/proc/run_loop
# equip_work.proc_queue を先頭から1件ずつ test:equip/proc/run_entry へ渡す

execute unless data storage test: equip_work.proc_queue[0] run return 0

function test:equip/proc/run_entry with storage test: equip_work.proc_queue[0]

data remove storage test: equip_work.proc_queue[0]
function test:equip/proc/run_loop
