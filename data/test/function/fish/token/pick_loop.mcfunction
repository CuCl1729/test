#> test:fish/token/pick_loop
# @s = プレイヤー。fish_work.entries の重みを順に足し、#fish_roll 以下になった行を渡して1を返す(無ければ0)

execute unless data storage test: fish_work.entries[0] run return 0
execute store result score #fish_w test.temporary run data get storage test: fish_work.entries[0].weight
scoreboard players operation #fish_acc test.temporary += #fish_w test.temporary
execute if score #fish_roll test.temporary <= #fish_acc test.temporary run return run function test:fish/token/give with storage test: fish_work.entries[0]
data remove storage test: fish_work.entries[0]
return run function test:fish/token/pick_loop
