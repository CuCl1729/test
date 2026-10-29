#> test:mine/token/pick_loop
# mine_work.weight_queue({rare,weight}の一覧)の重みを順に足し、#ore_roll 以下になったところのレア度に決める

execute unless data storage test: mine_work.weight_queue[0] run return 0
execute store result score #ore_w test.temporary run data get storage test: mine_work.weight_queue[0].weight
scoreboard players operation #ore_acc test.temporary += #ore_w test.temporary
execute if score #ore_roll test.temporary <= #ore_acc test.temporary run return run function test:mine/token/hit with storage test: mine_work.weight_queue[0]
data remove storage test: mine_work.weight_queue[0]
function test:mine/token/pick_loop
