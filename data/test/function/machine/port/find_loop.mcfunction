#> test:machine/port/find_loop
# @s = 機械のマーカー。machine_work.port_queue(搬入口の位置)を順に見て、原石の入っている最初の搬入口を探す。
# 見つかったら #machine_has_input = 1、machine_work.ore_port = その搬入口の位置、machine_work.take = その原石のスロット

execute unless data storage test: machine_work.port_queue[0] run return 0
function test:machine/port/find with storage test: machine_work.port_queue[0]
execute if score #machine_has_input test.temporary matches 1 run return run data modify storage test: machine_work.ore_port set from storage test: machine_work.port_queue[0]
data remove storage test: machine_work.port_queue[0]
function test:machine/port/find_loop
