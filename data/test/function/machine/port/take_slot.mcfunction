#> test:machine/port/take_slot
# 実行位置 = 搬入口。@macro Slot/count: 取り出すスロットと、その個数(ほかのキーも渡ってくるが使わない)。1個減らす(1個だけなら消す)

$scoreboard players set #take_c test.temporary $(count)
$execute if score #take_c test.temporary matches ..1 run return run data remove block ~ ~ ~ Items[{Slot:$(Slot)b}]
scoreboard players remove #take_c test.temporary 1
$execute store result block ~ ~ ~ Items[{Slot:$(Slot)b}].count int 1 run scoreboard players get #take_c test.temporary
