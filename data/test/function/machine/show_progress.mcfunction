#> test:machine/show_progress
# @s = 処理中の機械のマーカー。「処理中 <進み>%」と表示する(進み = test.machine.progress ÷ time。progress は ×100)

execute store result score #machine_time test.temporary run data get storage test: machine_work.def.time
scoreboard players operation #machine_pct test.temporary = @s test.machine.progress
scoreboard players operation #machine_pct test.temporary /= #machine_time test.temporary
data modify storage test: machine_work.progress set value {p:0}
execute store result storage test: machine_work.progress.p int 1 run scoreboard players get #machine_pct test.temporary
function test:machine/show_progress_label with storage test: machine_work.progress
