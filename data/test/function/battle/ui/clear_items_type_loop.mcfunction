#> test:battle/ui/clear_items_type_loop
# @s = プレイヤー。registry_work.type_queue(test:magic/registry/queue_types)のタイプアイコンを1件ずつ手元から消す

execute unless data storage test: registry_work.type_queue[-1] run return 0

data modify storage test: registry_work.type_entry set from storage test: registry_work.type_queue[-1]
data remove storage test: registry_work.type_queue[-1]

function test:battle/ui/clear_items_type with storage test: registry_work.type_entry

function test:battle/ui/clear_items_type_loop
