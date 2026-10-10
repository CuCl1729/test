#> test:debug/menu/rng_loop
# storage test: debug_work.rng_queue(init/asset/debug/rngの宣言のコピー)を先頭から1行ずつ表示する

execute unless data storage test: debug_work.rng_queue[0] run return 0

data modify storage test: debug_work.rng_entry set from storage test: debug_work.rng_queue[0]
function test:debug/menu/rng_line with storage test: debug_work.rng_entry

data remove storage test: debug_work.rng_queue[0]
function test:debug/menu/rng_loop
