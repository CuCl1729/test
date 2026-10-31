#> test:fish/token/roll
# @s = プレイヤー。@macro total: 重みの合計(ほかのキーも渡ってくるが使わない)。1〜合計で1回引き、重みを順に足して当たった行を渡す。
# デバッグで合計より大きい値に固定したときは、最後の行にする

$execute store result score #fish_roll test.temporary run function test:rng/roll {key:"fish_pick",min:1,max:$(total)}
scoreboard players set #fish_acc test.temporary 0
data modify storage test: fish_work.entries set from storage test: fish_work.pool.entries
execute store result score #fish_hit test.temporary run function test:fish/token/pick_loop
execute if score #fish_hit test.temporary matches 0 run function test:fish/token/give with storage test: fish_work.pool.entries[-1]
