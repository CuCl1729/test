#> test:item/weapon/lore/proc_loop
# lore_work.proc_queue(装備の自動発動の枠のコピー)を先頭から1枠ずつ、1行にして描く

execute unless data storage test: lore_work.proc_queue[0] run return 0

function test:item/weapon/lore/proc_line with storage test: lore_work.proc_queue[0]

data remove storage test: lore_work.proc_queue[0]
function test:item/weapon/lore/proc_loop
