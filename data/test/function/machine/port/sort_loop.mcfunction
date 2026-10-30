#> test:machine/port/sort_loop
# @s = 機械のマーカー。machine_work.port_queue(搬入口の位置 [{x,y,z}])の1つずつ、中身を整理する

execute unless data storage test: machine_work.port_queue[0] run return 0
function test:machine/port/sort with storage test: machine_work.port_queue[0]
data remove storage test: machine_work.port_queue[0]
function test:machine/port/sort_loop
