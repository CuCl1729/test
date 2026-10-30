#> test:machine/start
# @s = 処理していない、形の揃った機械のマーカー。搬入口の中から原石を探し(受け付けないものは test:machine/port/sort で出してある)、
# 見つかれば、蓄えた燃料から筐体の燃料の消費量(#machine_fuel_use)を引いて1個取り出し、処理を始める。
# 燃料が足りなければ「燃料切れ」

scoreboard players set #machine_has_input test.temporary 0
data modify storage test: machine_work.port_queue set from storage test: machine_work.inputs
function test:machine/port/find_loop
execute if score #machine_has_input test.temporary matches 0 run return 0

execute if score @s test.machine.fuel < #machine_fuel_use test.temporary run return run scoreboard players set #machine_no_fuel test.temporary 1
scoreboard players operation @s test.machine.fuel -= #machine_fuel_use test.temporary

function test:machine/port/take with storage test: machine_work.ore_port
scoreboard players set @s test.machine.progress 0
