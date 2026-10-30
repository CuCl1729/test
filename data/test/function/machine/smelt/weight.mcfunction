#> test:machine/smelt/weight
# machine_work.main_queue[0] の重み(weight + weight_rare × (レア度−1))を #main_w に入れる

execute store result score #main_w test.temporary run data get storage test: machine_work.main_queue[0].weight
execute store result score #main_t test.temporary run data get storage test: machine_work.main_queue[0].weight_rare
scoreboard players operation #main_t test.temporary *= #ore_rare1 test.temporary
scoreboard players operation #main_w test.temporary += #main_t test.temporary
