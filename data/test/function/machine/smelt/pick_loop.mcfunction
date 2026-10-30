#> test:machine/smelt/pick_loop
# machine_work.main_queue の重みを順に足し、#main_roll 以下になったところの行に決める(mine/token/pick_loop と同じ選び方)

execute unless data storage test: machine_work.main_queue[0] run return 0
function test:machine/smelt/weight
scoreboard players operation #main_acc test.temporary += #main_w test.temporary
execute if score #main_roll test.temporary <= #main_acc test.temporary run return run function test:machine/smelt/hit with storage test: machine_work.main_queue[0]
data remove storage test: machine_work.main_queue[0]
function test:machine/smelt/pick_loop
