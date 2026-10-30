#> test:machine/drop_here_loop
# 実行位置に、machine_work.drop を1つずつアイテムとして落とす(test:item/drop_at)

execute unless data storage test: machine_work.drop[0] run return 0
data modify storage test: loot.item set from storage test: machine_work.drop[0]
data remove storage test: machine_work.drop[0]
function test:item/drop_at
function test:machine/drop_here_loop
