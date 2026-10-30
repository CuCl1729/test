#> test:debug/factory_info
# @s = プレイヤー。自分の工場の区画の番号・角の座標・作り終えたか・forceload されているかを出す

execute unless score @s test.factory.plot matches 1.. run return run tellraw @s {text:"工場の区画はまだ無い(鍵で工場へ行くと割り当てる)",color:"gray"}
data modify storage test: factory_work.plot_arg set value {n:0}
execute store result storage test: factory_work.plot_arg.n int 1 run scoreboard players get @s test.factory.plot
function test:factory/plot_area with storage test: factory_work.plot_arg
function test:debug/factory_info_show with storage test: factory_work.plot
