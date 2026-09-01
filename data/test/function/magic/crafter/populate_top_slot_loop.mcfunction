#> test:magic/crafter/populate_top_slot_loop
# registry_work.top_known(読み飛ばし済み、先頭が表示すべき最初の1件)を末尾ではなく
# 先頭[0]から取り出す。最大7件、#top_slot(1始まり)を詰め先スロットとして使う

execute unless data storage test: registry_work.top_known[0] run return 0
execute if score #top_slot test.buff.work matches 8.. run return 0

data modify storage test: registry_work.top_entry set from storage test: registry_work.top_known[0]
data remove storage test: registry_work.top_known[0]
execute store result storage test: registry_work.top_entry.slot int 1 run scoreboard players get #top_slot test.buff.work

function test:magic/crafter/populate_top_slot with storage test: registry_work.top_entry

scoreboard players add #top_slot test.buff.work 1

function test:magic/crafter/populate_top_slot_loop
