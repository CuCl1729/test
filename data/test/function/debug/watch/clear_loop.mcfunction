#> test:debug/watch/clear_loop

execute unless data storage test: debug_work.watch_queue[0] run return 0

function test:debug/watch/reset_line with storage test: debug_work.watch_queue[0]

data remove storage test: debug_work.watch_queue[0]
function test:debug/watch/clear_loop
