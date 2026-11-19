#> test:buff/events/drain_step
# 内部。先入れ先出しで1件ずつ配る。仕事は値として写すので、配っている最中に積まれた分は
# ただ後ろに回るだけで混ざらない

data remove storage test: buff_drain.job
data modify storage test: buff_drain.job set from storage test: buff_queue.jobs[0]
data remove storage test: buff_queue.jobs[0]
function test:buff/events/fire with storage test: buff_drain.job
execute if data storage test: buff_queue.jobs[0] run function test:buff/events/drain_step
