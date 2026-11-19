#> test:buff/events/project/emit
# 内部。groups を順に jobs へ写し、count(選ばれたユニット数)を刻む

data remove storage test: buff_project.work.job
data modify storage test: buff_project.work.job set from storage test: buff_project.work.groups[0].job
data remove storage test: buff_project.work.groups[0]

data modify storage test: buff_project.work.job.count set value 0
execute store result storage test: buff_project.work.job.count int 1 run data get storage test: buff_project.work.job.units

data modify storage test: buff_project.work.jobs append from storage test: buff_project.work.job

execute if data storage test: buff_project.work.groups[0] run function test:buff/events/project/emit
