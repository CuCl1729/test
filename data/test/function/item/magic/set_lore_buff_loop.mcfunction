#> test:item/magic/set_lore_buff_loop
# 付与するバフの一覧を末尾から1件ずつ取り出してロアに1行足す
# (先頭から削ると後続要素が毎回ずれて重いため、末尾[-1]から削る)

execute unless data storage test: registry_work.lore_buff_queue[-1] run return 0

data modify storage test: registry_work.lore_buff_entry set from storage test: registry_work.lore_buff_queue[-1]
data remove storage test: registry_work.lore_buff_queue[-1]

function test:item/magic/set_lore_buff with storage test: registry_work.lore_buff_entry

function test:item/magic/set_lore_buff_loop
