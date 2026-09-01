#> test:buff/step_loop
# buff_work.list を末尾から取り出して1件ずつ進め、生き残ったものを buff_work.out へ積む

execute unless data storage test: buff_work.list[-1] run return 0

data modify storage test: buff_work.entry set from storage test: buff_work.list[-1]
data remove storage test: buff_work.list[-1]

function test:buff/step_entry with storage test: buff_work.entry

function test:buff/step_loop
