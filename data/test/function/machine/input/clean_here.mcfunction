#> test:machine/input/clean_here
# @s = 機械のマーカー(実行位置は原石の入れ物)。中身を1スロットずつ見る

data modify storage test: machine_work.items set value []
data modify storage test: machine_work.items set from block ~ ~ ~ Items
function test:machine/input/clean_loop
