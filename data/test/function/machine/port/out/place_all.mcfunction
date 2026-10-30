#> test:machine/port/out/place_all
# @s = 機械のマーカー(実行位置は核の中心)。出すもの(machine_work.drop)を1スタックずつ、搬出口の中に入れる。
# スタックごとに使い始める搬出口を test.machine.out_rr で回し、いっぱいなら次の搬出口へ。
# どの搬出口にも入りきらなかった分は data.machine.pending に持つ(次の秒にまた入れてみる)

execute unless data storage test: machine_work.drop[0] run return 0
execute store result score #out_n test.temporary run data get storage test: machine_work.outputs

data modify storage test: machine_work.stack set from storage test: machine_work.drop[0]
data remove storage test: machine_work.drop[0]
data remove storage test: machine_work.stack.Slot
execute unless data storage test: machine_work.stack.components run data modify storage test: machine_work.stack.components set value {}
scoreboard players set #stack_left test.temporary 1
execute if data storage test: machine_work.stack.count store result score #stack_left test.temporary run data get storage test: machine_work.stack.count

scoreboard players set #out_try test.temporary 0
function test:machine/port/out/place_try_loop
execute if score #stack_left test.temporary matches 1.. store result storage test: machine_work.stack.count int 1 run scoreboard players get #stack_left test.temporary
execute if score #stack_left test.temporary matches 1.. run data modify entity @s data.machine.pending append from storage test: machine_work.stack
scoreboard players add @s test.machine.out_rr 1

function test:machine/port/out/place_all
