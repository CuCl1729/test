#> test:battle/action/item_line_loop
# @s = プレイヤー。registry_work.item_queue(battle.temporary.item_slot のコピー)を1件ずつ、番号付きの行にして出す

execute unless data storage test: registry_work.item_queue[0] run return 0

scoreboard players add #item_line test.temporary 1
data modify storage test: registry_work.item_line set from storage test: registry_work.item_queue[0]
execute store result storage test: registry_work.item_line.index int 1 run scoreboard players get #item_line test.temporary
data remove storage test: registry_work.item_queue[0]
function test:battle/action/item_line with storage test: registry_work.item_line

function test:battle/action/item_line_loop
