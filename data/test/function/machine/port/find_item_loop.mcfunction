#> test:machine/port/find_item_loop
# machine_work.items(搬入口の中身のコピー)から、最初の原石を machine_work.take にして #machine_has_input = 1 にする

execute unless data storage test: machine_work.items[0] run return 0
execute if data storage test: machine_work.items[0].components."minecraft:custom_data".test.ore run data modify storage test: machine_work.take set from storage test: machine_work.items[0]
execute if data storage test: machine_work.items[0].components."minecraft:custom_data".test.ore run return run scoreboard players set #machine_has_input test.temporary 1
data remove storage test: machine_work.items[0]
function test:machine/port/find_item_loop
