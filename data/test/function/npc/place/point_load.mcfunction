#> test:npc/place/point_load
# npc_work.queue の先頭の NPC の定義を npc_work.p に写す

data modify storage test: npc_work.arg set value {id:""}
data modify storage test: npc_work.arg.id set from storage test: npc_work.queue[0]
function test:npc/place/point_copy with storage test: npc_work.arg
