#> test:item/material/give_hits_loop
# item_work.material_give_queue を先頭から1件ずつ渡す

execute unless data storage test: item_work.material_give_queue[0] run return 0

data modify storage test: item_work.material_give set from storage test: item_work.material_give_queue[0]
data remove storage test: item_work.material_give_queue[0]
function test:item/material/give with storage test: item_work.material_give

function test:item/material/give_hits_loop
