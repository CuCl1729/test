#> test:machine/port/out/shrink_slot
# 実行位置 = 搬出口。@macro Slot: スロット。#stack_left 個にする(0なら消す)

$execute if score #stack_left test.temporary matches ..0 run return run data remove block ~ ~ ~ Items[{Slot:$(Slot)b}]
$execute store result block ~ ~ ~ Items[{Slot:$(Slot)b}].count int 1 run scoreboard players get #stack_left test.temporary
