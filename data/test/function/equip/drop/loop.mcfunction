#> test:equip/drop/loop

execute unless data storage test: equip_work.drop_queue[0] run return 0

data modify storage test: equip_work.drop set from storage test: equip_work.drop_queue[0]
function test:equip/drop/roll with storage test: equip_work.drop

data remove storage test: equip_work.drop_queue[0]
function test:equip/drop/loop
