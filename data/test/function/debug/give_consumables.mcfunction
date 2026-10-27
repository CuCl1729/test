#> test:debug/give_consumables
# @s = プレイヤー。消耗品を全種類(asset.consumable_ids)16個ずつ、インベントリに直接渡す

data modify storage test: debug_work.give_queue set value []
data modify storage test: debug_work.give_queue set from storage test: asset.consumable_ids
data modify storage test: loot.context set value "inventory"
function test:debug/give_consumables_loop
data remove storage test: loot.context
