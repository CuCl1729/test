#> test:item/weapon/lore/special_buff_loop
# lore_work.buff_queue(custom_data.test.buff_on_hitのコピー)を先頭から1件ずつ描く

execute unless data storage test: lore_work.buff_queue[0] run return 0

data modify storage test: lore_work.buff set from storage test: lore_work.buff_queue[0]
function test:item/weapon/lore/special_buff with storage test: lore_work.buff

data remove storage test: lore_work.buff_queue[0]
function test:item/weapon/lore/special_buff_loop
