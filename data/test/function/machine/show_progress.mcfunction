#> test:machine/show_progress
# @s = 処理中の機械のマーカー。「処理中 <進み>/<秒>」と表示する

data modify storage test: machine_work.progress set value {p:0,t:0}
execute store result storage test: machine_work.progress.p int 1 run scoreboard players get @s test.machine.progress
data modify storage test: machine_work.progress.t set from storage test: machine_work.def.time
function test:machine/show_progress_label with storage test: machine_work.progress
