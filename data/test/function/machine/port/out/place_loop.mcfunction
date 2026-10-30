#> test:machine/port/out/place_loop
# 実行位置 = 搬出口。machine_work.stack を1個ずつ入れ、入るたびに #stack_left を1減らす。入らなくなったら終える

execute if score #stack_left test.temporary matches ..0 run return 0
function test:machine/port/out/insert_one with storage test: machine_work.stack
execute if score #ins test.temporary matches ..0 run return 0
scoreboard players remove #stack_left test.temporary 1
function test:machine/port/out/place_loop
