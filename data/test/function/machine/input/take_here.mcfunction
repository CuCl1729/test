#> test:machine/input/take_here
# @s = 機械のマーカー(実行位置は原石の入れ物)

data modify entity @s data.machine.processing set from block ~ ~ ~ Items[0]
data remove entity @s data.machine.processing.Slot
data modify entity @s data.machine.processing.count set value 1
function test:machine/take_one
