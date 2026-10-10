#> test:debug/watch/tick_loop

execute unless data storage test: debug_work.watch_tick_queue[0] run return 0

function test:debug/watch/tick_entry with storage test: debug_work.watch_tick_queue[0]

data remove storage test: debug_work.watch_tick_queue[0]
function test:debug/watch/tick_loop
