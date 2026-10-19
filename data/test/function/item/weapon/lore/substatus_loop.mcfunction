#> test:item/weapon/lore/substatus_loop
# lore_work.sub_queue(substatusのコピー)を先頭から1件ずつ、+付きで描く

execute unless data storage test: lore_work.sub_queue[0] run return 0

data modify storage test: lore_work.stat set from storage test: lore_work.sub_queue[0]
data modify storage test: lore_work.stat.sign set value "+"
function test:item/weapon/lore/stat_line with storage test: lore_work.stat

data remove storage test: lore_work.sub_queue[0]
function test:item/weapon/lore/substatus_loop
