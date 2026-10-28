#> test:equip/proc/watch_check_loop
# equip_work.watch_queue を先頭から見て、below を持つイベントを {id, stat, max, percent} にして watch_check_entry に渡す

execute unless data storage test: equip_work.watch_queue[0] run return 0

execute if data storage test: equip_work.watch_queue[0].below run data modify storage test: equip_work.watch_cur set from storage test: equip_work.watch_queue[0].below
execute if data storage test: equip_work.watch_queue[0].below run data modify storage test: equip_work.watch_cur.id set from storage test: equip_work.watch_queue[0].id
execute if data storage test: equip_work.watch_queue[0].below run function test:equip/proc/watch_check_entry with storage test: equip_work.watch_cur

data remove storage test: equip_work.watch_queue[0]
function test:equip/proc/watch_check_loop
