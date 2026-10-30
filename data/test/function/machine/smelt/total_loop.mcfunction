#> test:machine/smelt/total_loop
# machine_work.main_queue の重みを全部足して #main_total にする

execute unless data storage test: machine_work.main_queue[0] run return 0
function test:machine/smelt/weight
scoreboard players operation #main_total test.temporary += #main_w test.temporary
data remove storage test: machine_work.main_queue[0]
function test:machine/smelt/total_loop
