#> test:item/magic/set_lore_type_loop
# レジストリを末尾から1件ずつ取り出し、そのタイプが使われていればロアに1行足す
# (先頭から削ると後続要素が毎回ずれて重いため、末尾[-1]から削る)

execute unless data storage test: registry_work.lore_type_queue[-1] run return 0

data modify storage test: registry_work.lore_type_entry set from storage test: registry_work.lore_type_queue[-1]
data remove storage test: registry_work.lore_type_queue[-1]

function test:item/magic/set_lore_type with storage test: registry_work.lore_type_entry

function test:item/magic/set_lore_type_loop
