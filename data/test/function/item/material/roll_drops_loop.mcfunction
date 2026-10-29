#> test:item/material/roll_drops_loop
# item_work.material_drop_queue を先頭から1件ずつ抽選する

execute unless data storage test: item_work.material_drop_queue[0] run return 0

data modify storage test: item_work.material_drop set from storage test: item_work.material_drop_queue[0]
data remove storage test: item_work.material_drop_queue[0]
function test:item/material/roll_drop with storage test: item_work.material_drop

function test:item/material/roll_drops_loop
