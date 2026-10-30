#> test:machine/progress
# @s = 処理中の機械のマーカー。1秒ごとに筐体の処理速度(#machine_speed、%)ぶん進め(test.machine.progress は ×100)、
# 定義の time 秒 × 100 に達したら結果を出す

scoreboard players operation @s test.machine.progress += #machine_speed test.temporary
execute store result score #machine_time test.temporary run data get storage test: machine_work.def.time
scoreboard players operation #machine_time test.temporary *= #100 test.constant
execute if score @s test.machine.progress >= #machine_time test.temporary run function test:machine/finish
