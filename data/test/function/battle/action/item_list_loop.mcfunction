#> test:battle/action/item_list_loop
# registry_work.item_queue(消耗品のidの一覧)を先頭から1件ずつ数える。8件そろったら打ち切る

execute unless data storage test: registry_work.item_queue[0] run return 0
execute if score #item_slot test.temporary matches 8.. run return 0

data modify storage test: registry_work.item_entry set value {id:""}
data modify storage test: registry_work.item_entry.id set from storage test: registry_work.item_queue[0]
data remove storage test: registry_work.item_queue[0]
function test:battle/action/item_list_entry with storage test: registry_work.item_entry

function test:battle/action/item_list_loop
