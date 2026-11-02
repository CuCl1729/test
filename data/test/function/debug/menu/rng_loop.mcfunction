#> test:debug/menu/rng_loop
# storage test: debug_work.rng_queue(init/asset/debug/rngの宣言のコピー)を先頭から見て、#rng_skip 個を飛ばし、
# 続く #rng_left 個を1つずつ表示する(test:debug/menu/page/rng)。表示しなかった残りは queue に残る

execute unless data storage test: debug_work.rng_queue[0] run return 0
execute if score #rng_left test.temporary matches ..0 run return 0

data modify storage test: debug_work.rng_entry set from storage test: debug_work.rng_queue[0]
execute if score #rng_skip test.temporary matches ..0 run function test:debug/menu/rng_line with storage test: debug_work.rng_entry
execute if score #rng_skip test.temporary matches ..0 run scoreboard players remove #rng_left test.temporary 1
scoreboard players remove #rng_skip test.temporary 1

data remove storage test: debug_work.rng_queue[0]
function test:debug/menu/rng_loop
