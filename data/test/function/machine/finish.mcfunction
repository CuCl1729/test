#> test:machine/finish
# @s = 処理の終わった機械のマーカー。持っていた原石(data.machine.processing)の種類・レア度・段階で結果を決め、
# 出すもの(machine_work.drop)に足す。前処理は test:machine/pre/finish、精錬炉は test:machine/smelt/finish

function test:machine/ore_info
execute if data storage test: machine_work.def{kind:"pre"} run function test:machine/pre/finish
execute if data storage test: machine_work.def{kind:"smelt"} run function test:machine/smelt/finish
data remove entity @s data.machine.processing
scoreboard players set @s test.machine.progress 0
