#> test:machine/port/out/push_insert_loop
# 実行位置 = 送り先。machine_work.stack を1個ずつ入れ、入るたびに #stack_left と #push_budget を1減らす。
# 入らなければ #push_full = 1 にして終える

execute if score #stack_left test.temporary matches ..0 run return 0
execute if score #push_budget test.temporary matches ..0 run return 0
function test:machine/port/out/insert_one with storage test: machine_work.stack
execute if score #ins test.temporary matches ..0 run return run scoreboard players set #push_full test.temporary 1
scoreboard players remove #stack_left test.temporary 1
scoreboard players remove #push_budget test.temporary 1
function test:machine/port/out/push_insert_loop
