#> test:machine/port/out/push_shrink
# @s = 機械のマーカー。@macro x/y/z: 搬出口の、核からのずれ(ほかのキーも渡ってくるが使わない)。
# 送った分だけ、搬出口のそのスロット(machine_work.stack.Slot)を #stack_left 個にする(0なら消す)

data modify storage test: machine_work.shrink set value {Slot:0b}
data modify storage test: machine_work.shrink.Slot set from storage test: machine_work.stack.Slot
$execute at @s positioned ~$(x) ~$(y) ~$(z) run function test:machine/port/out/shrink_slot with storage test: machine_work.shrink
