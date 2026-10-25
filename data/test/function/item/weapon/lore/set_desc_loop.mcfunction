#> test:item/weapon/lore/set_desc_loop
# lore_work.desc_queue(シリーズのbonus4のコピー)を先頭から1件ずつ、説明文(desc)として描く

execute unless data storage test: lore_work.desc_queue[0] run return 0

function test:item/weapon/lore/line_begin
data modify storage test: lore_work.line append value {text:"✹ ",color:"gold"}
data modify storage test: lore_work.line append value {text:"",color:"gray"}
data modify storage test: lore_work.line[-1].text set from storage test: lore_work.desc_queue[0].desc
function test:item/weapon/lore/commit

data remove storage test: lore_work.desc_queue[0]
function test:item/weapon/lore/set_desc_loop
