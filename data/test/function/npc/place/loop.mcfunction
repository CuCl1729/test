#> test:npc/place/loop
# npc_work.queue(asset.npc_ids のコピー)を1件ずつ、両方のマップに置く

execute unless data storage test: npc_work.queue[0] run return 0
data modify storage test: npc_work.p set value {}
function test:npc/place/point_load with storage test: npc_work
data remove storage test: npc_work.queue[0]
data modify storage test: npc_work.p.dim set value "action"
function test:npc/place/try with storage test: npc_work.p
data modify storage test: npc_work.p.dim set value "turn"
function test:npc/place/try with storage test: npc_work.p
function test:npc/place/loop
