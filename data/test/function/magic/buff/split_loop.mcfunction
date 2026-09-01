#> test:magic/buff/split_loop
# magic_buff.queue を末尾から1件ずつ取り出して振り分ける

execute unless data storage test: magic_buff.queue[-1] run return 0

data modify storage test: magic_buff.entry set from storage test: magic_buff.queue[-1]
data remove storage test: magic_buff.queue[-1]

function test:magic/buff/split_entry with storage test: magic_buff.entry

function test:magic/buff/split_loop
