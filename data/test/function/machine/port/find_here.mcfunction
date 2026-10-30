#> test:machine/port/find_here
# 実行位置 = 搬入口。中身のコピーを1スロットずつ見て、原石(custom_data.test.ore)があれば machine_work.take にする

data modify storage test: machine_work.items set value []
data modify storage test: machine_work.items set from block ~ ~ ~ Items
function test:machine/port/find_item_loop
