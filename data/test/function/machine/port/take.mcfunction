#> test:machine/port/take
# @s = 機械のマーカー。@macro x/y/z: 原石の入っている搬入口(machine_work.ore_port)。machine_work.take のスロットから1個取り出し、
# 処理が終わるまでマーカーのデータ(data.machine.processing)に持っておく

data modify entity @s data.machine.processing set from storage test: machine_work.take
data remove entity @s data.machine.processing.Slot
data modify entity @s data.machine.processing.count set value 1
$execute positioned ~$(x) ~$(y) ~$(z) run function test:machine/port/take_slot with storage test: machine_work.take
