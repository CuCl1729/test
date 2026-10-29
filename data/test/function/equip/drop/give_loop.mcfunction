#> test:equip/drop/give_loop
# equip_work.give_queue を先頭から1件ずつ渡す

execute unless data storage test: equip_work.give_queue[0] run return 0

data modify storage test: equip_work.give set from storage test: equip_work.give_queue[0]
data remove storage test: equip_work.give_queue[0]
function test:equip/drop/give with storage test: equip_work.give

function test:equip/drop/give_loop
