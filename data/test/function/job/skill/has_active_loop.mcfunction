#> test:job/skill/has_active_loop
# job_work.active_queue を先頭から見て、発動できるもの(test:job/skill/is_active)が見つかれば1を返す

execute unless data storage test: job_work.active_queue[0] run return 0
data modify storage test: job_work.active_check set from storage test: job_work.active_queue[0]
data remove storage test: job_work.active_queue[0]
execute store result score #job_active test.job.work run function test:job/skill/is_active with storage test: job_work.active_check
execute if score #job_active test.job.work matches 1 run return 1
return run function test:job/skill/has_active_loop
