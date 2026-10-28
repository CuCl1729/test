#> test:equip/proc/watch_recalc_loop
# equip_work.watch_queue(イベントの一覧のコピー)を先頭から見て、below を持つものを watch_recalc_entry に渡す

execute unless data storage test: equip_work.watch_queue[0] run return 0

execute if data storage test: equip_work.watch_queue[0].below run function test:equip/proc/watch_recalc_entry with storage test: equip_work.watch_queue[0]

data remove storage test: equip_work.watch_queue[0]
function test:equip/proc/watch_recalc_loop
