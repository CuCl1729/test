#> test:item/weapon/lore/proc_loop
# lore_work.proc_queue(装備の自動発動の枠のコピー)を先頭から1枠ずつ、1行にして描く。今の枠は lore_work.proc_cur に置く

execute unless data storage test: lore_work.proc_queue[0] run return 0

data modify storage test: lore_work.proc_cur set from storage test: lore_work.proc_queue[0]
execute if data storage test: lore_work.proc_cur{kind:"rune"} run function test:item/weapon/lore/proc_rune
execute unless data storage test: lore_work.proc_cur{kind:"rune"} run function test:item/weapon/lore/proc_line with storage test: lore_work.proc_cur

data remove storage test: lore_work.proc_queue[0]
function test:item/weapon/lore/proc_loop
