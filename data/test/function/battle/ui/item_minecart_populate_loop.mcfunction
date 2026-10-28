#> test:battle/ui/item_minecart_populate_loop
# registry_work.item_queue(battle.temporary.item_slot のコピー)を1件ずつ、スロット0から順にトロッコへ入れる

execute unless data storage test: registry_work.item_queue[0] run return 0

data modify storage test: registry_work.item_line set from storage test: registry_work.item_queue[0]
data remove storage test: registry_work.item_queue[0]
function test:battle/ui/item_minecart_populate_slot with storage test: registry_work.item_line
scoreboard players add #item_line test.temporary 1

function test:battle/ui/item_minecart_populate_loop
