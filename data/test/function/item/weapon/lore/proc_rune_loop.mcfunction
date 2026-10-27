#> test:item/weapon/lore/proc_rune_loop
# lore_work.rune_queue(ルーンの枠の能力)を先頭から1つずつ、作りかけの行に並べる

execute unless data storage test: lore_work.rune_queue[0] run return 0

data modify storage test: lore_work.line append value {text:"  "}
data modify storage test: lore_work.stat set from storage test: lore_work.rune_queue[0]
data modify storage test: lore_work.stat.sign set value "+"
function test:item/weapon/lore/stat_parts with storage test: lore_work.stat

data remove storage test: lore_work.rune_queue[0]
function test:item/weapon/lore/proc_rune_loop
