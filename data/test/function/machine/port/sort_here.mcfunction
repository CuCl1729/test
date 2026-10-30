#> test:machine/port/sort_here
# @s = 機械のマーカー(実行位置は搬入口)

data modify storage test: machine_work.items set value []
data modify storage test: machine_work.items set from block ~ ~ ~ Items
function test:machine/port/sort_item_loop
