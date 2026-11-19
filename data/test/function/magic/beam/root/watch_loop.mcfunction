#> test:magic/beam/root/watch_loop
# beam_root_work.watch_in を先頭から1件ずつ見て、残すものだけ beam_root_work.keep に移す
execute unless data storage test: beam_root_work.watch_in[0] run return 1

data modify storage test: beam_root_work.watch_entry set from storage test: beam_root_work.watch_in[0]
data remove storage test: beam_root_work.watch_in[0]
function test:magic/beam/root/watch_one with storage test: beam_root_work.watch_entry

function test:magic/beam/root/watch_loop
