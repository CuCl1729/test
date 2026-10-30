#> test:machine/start
# @s = 処理していない、形の揃った機械のマーカー。原石の入れ物に物があれば(受け付けないものは machine/input/clean で出してある)、
# 燃料を1回分使って1個取り出し、処理を始める。残りの燃料が0なら燃料の入れ物から1個取り出して足し、それも無ければ「燃料切れ」

scoreboard players set #machine_has_input test.temporary 0
function test:machine/input/peek with storage test: machine_work.def.input
execute if score #machine_has_input test.temporary matches 0 run return 0

execute if score @s test.machine.fuel matches ..0 run function test:machine/fuel/take with storage test: machine_work.def.fuel
execute if score @s test.machine.fuel matches ..0 run return run scoreboard players set #machine_no_fuel test.temporary 1
scoreboard players remove @s test.machine.fuel 1

function test:machine/input/take with storage test: machine_work.def.input
scoreboard players set @s test.machine.progress 0
