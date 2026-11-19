#> test:buff/native/group_loop
# 内部。buff_native.work.groups の先頭のまとまりを取り出し、その段を数えてから次へ回す

data modify storage test: buff_native.work.units set value []
execute if data storage test: buff_native.work.groups[0].units[0] run data modify storage test: buff_native.work.units set from storage test: buff_native.work.groups[0].units
data remove storage test: buff_native.work.groups[0]

execute if data storage test: buff_native.work.units[0] run function test:buff/native/unit_loop
execute if data storage test: buff_native.work.groups[0] run function test:buff/native/group_loop
