#> test:buff/events/enqueue
# 内部。投影の結果(result.jobs)を待ち行列の末尾へ足す。待ち行列を書くのはここだけ

execute unless data storage test: buff_queue.jobs run data modify storage test: buff_queue.jobs set value []
execute if data storage test: buff_project.result.jobs[0] run data modify storage test: buff_queue.jobs append from storage test: buff_project.result.jobs[]
