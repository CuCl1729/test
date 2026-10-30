#> test:machine/smelt/finish
# @s = 精錬炉のマーカー。machine_work.ore = 処理した原石(種類・レア度・段階)。どちらも test:rng/roll を通す。
# 1. 主産物: asset.refine.<原石>.main から必ず1つ重みで選ぶ(rng のキー refine_main、1..重みの合計)。
#    重み = weight + weight_rare × (レア度−1)、個数 = count + count_stage × 段階
# 2. 副産物: asset.refine.<原石>.by を1行ずつ判定する(rng のキー refine_by。test:machine/by/loop)

data modify storage test: machine_work.main set value []
data modify storage test: machine_work.by set value []
function test:machine/smelt/load with storage test: machine_work.ore
execute unless data storage test: machine_work.main[0] run return run function test:machine/smelt/no_def with storage test: machine_work.ore

# 重みの合計
scoreboard players set #main_total test.temporary 0
data modify storage test: machine_work.main_queue set from storage test: machine_work.main
function test:machine/smelt/total_loop
execute store result storage test: machine_work.roll_arg.max int 1 run scoreboard players get #main_total test.temporary
function test:machine/smelt/roll with storage test: machine_work.roll_arg

# 重みを順に足し、#main_roll 以下になった行に決める
scoreboard players set #main_acc test.temporary 0
scoreboard players set #main_hit test.temporary 0
data modify storage test: machine_work.main_queue set from storage test: machine_work.main
function test:machine/smelt/pick_loop
# デバッグで合計より大きい値に固定したときは、最後の行にする
execute if score #main_hit test.temporary matches 0 run function test:machine/smelt/hit with storage test: machine_work.main[-1]

data modify storage test: machine_work.by_arg set value {key:"refine_by"}
function test:machine/by/loop
