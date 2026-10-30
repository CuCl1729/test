#> test:machine/port/out/push_loop
# @s = 機械のマーカー。machine_work.push_queue(搬出口と送り先 [{x,y,z,tx,ty,tz}])を1つずつ送る

execute unless data storage test: machine_work.push_queue[0] run return 0
data modify storage test: machine_work.push set from storage test: machine_work.push_queue[0]
data remove storage test: machine_work.push_queue[0]
function test:machine/port/out/push with storage test: machine_work.push
function test:machine/port/out/push_loop
