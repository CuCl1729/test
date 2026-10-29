#> test:mine/token/roll
# @macro weight_total: 重みの合計(ほかのキーも渡ってくるが使わない)。1〜合計で1回引き、重みを順に足していって
# 当たったレア度の個数(#ore_r<レア度>)を1増やす

$execute store result score #ore_roll test.temporary run function test:rng/roll {key:"ore_rarity",min:1,max:$(weight_total)}
scoreboard players set #ore_acc test.temporary 0
scoreboard players set #ore_hit test.temporary 0
data modify storage test: mine_work.weight_queue set from storage test: mine_work.mine.weights
function test:mine/token/pick_loop
# デバッグで合計より大きい値に固定したときは、最後のレア度にする
execute if score #ore_hit test.temporary matches 0 run function test:mine/token/hit with storage test: mine_work.mine.weights[-1]
