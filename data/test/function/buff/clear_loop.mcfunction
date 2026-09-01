#> test:buff/clear_loop
# buff_work.list を末尾から空にしながら、1件ずつ終了イベントを予約する

execute unless data storage test: buff_work.list[-1] run return 0

data modify storage test: buff_work.entry set from storage test: buff_work.list[-1]
data remove storage test: buff_work.list[-1]

function test:buff/clear_entry with storage test: buff_work.entry

function test:buff/clear_loop
