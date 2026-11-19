#> test:buff/events/project
# 入口。渡されたイベント列(arg.events)を仕事列(result.jobs)へ写すだけの純粋な関数。
# 作業域(work)しか触らない。待ち行列を触るのは enqueue の役目

data remove storage test: buff_project.work
data modify storage test: buff_project.work set value {jobs:[],events:[]}
data modify storage test: buff_project.work.events set from storage test: buff_project.arg.events
execute if data storage test: buff_project.work.events[0] run function test:buff/events/project/event
data remove storage test: buff_project.result
data modify storage test: buff_project.result set value {jobs:[]}
execute if data storage test: buff_project.work.jobs[0] run data modify storage test: buff_project.result.jobs set from storage test: buff_project.work.jobs
data remove storage test: buff_project.work
return 1
