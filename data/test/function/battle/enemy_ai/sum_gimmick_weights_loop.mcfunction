#> test:battle/enemy_ai/sum_gimmick_weights_loop
# enemy_ai_work.weight_sum_queue(候補のコピー)を末尾から取り出し、#total_weightへ重みを合算する

execute unless data storage test: enemy_ai_work.weight_sum_queue[-1] run return 0

scoreboard players set #w test.buff.work 0
execute store result score #w test.buff.work run data get storage test: enemy_ai_work.weight_sum_queue[-1].weight
scoreboard players operation #total_weight test.buff.work += #w test.buff.work

data remove storage test: enemy_ai_work.weight_sum_queue[-1]

function test:battle/enemy_ai/sum_gimmick_weights_loop
