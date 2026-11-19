#> test:buff/events/drain
# 内部。待ち行列を1回だけ空にする。再入はしない(配っている最中に積まれた分は後で届く)

execute if score #bq_draining test.buff.work matches 1 run return 0
execute unless data storage test: buff_queue.jobs[0] run return 0
scoreboard players set #bq_draining test.buff.work 1
function test:buff/events/drain_step
scoreboard players set #bq_draining test.buff.work 0
return 1
