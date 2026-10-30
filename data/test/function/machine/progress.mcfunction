#> test:machine/progress
# @s = 処理中の機械のマーカー。1秒進め、定義の time 秒に達したら結果を出す

scoreboard players add @s test.machine.progress 1
execute store result score #machine_time test.temporary run data get storage test: machine_work.def.time
execute if score @s test.machine.progress >= #machine_time test.temporary run function test:machine/finish
