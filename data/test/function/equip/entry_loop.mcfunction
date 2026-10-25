#> test:equip/entry_loop
# storage test: equip_work.entry_queue({type,value}の一覧)を先頭から1件ずつ集計値に足す

execute unless data storage test: equip_work.entry_queue[0] run return 0

data modify storage test: equip_work.entry set from storage test: equip_work.entry_queue[0]
function test:equip/add_entry with storage test: equip_work.entry

data remove storage test: equip_work.entry_queue[0]
function test:equip/entry_loop
