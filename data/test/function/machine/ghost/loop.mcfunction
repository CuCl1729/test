#> test:machine/ghost/loop
# @s = 機械のマーカー。machine_work.ghost_queue(足りない位置 [{x,y,z}])の1か所ずつ、ゴーストを置く(すでにあれば印を外すだけ)

execute unless data storage test: machine_work.ghost_queue[0] run return 0
data modify storage test: machine_work.ghost_arg.x set from storage test: machine_work.ghost_queue[0].x
data modify storage test: machine_work.ghost_arg.y set from storage test: machine_work.ghost_queue[0].y
data modify storage test: machine_work.ghost_arg.z set from storage test: machine_work.ghost_queue[0].z
data remove storage test: machine_work.ghost_queue[0]
function test:machine/ghost/place with storage test: machine_work.ghost_arg
function test:machine/ghost/loop
