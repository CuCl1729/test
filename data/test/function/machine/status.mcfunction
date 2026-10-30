#> test:machine/status
# @s = 機械のマーカー。@macro label/color: 状態(未完成・筐体が混在・搬入口なし・搬出口なし・燃料切れ・待機・処理中 40% など)と色。
# 頭上の表示(text_display、tag=machine_label)を「<名前> [<状態>] 燃料 <回数>」にし、同じ文をマーカーの data.machine.label にも残す
# (test:debug/machine_status が表示する)。名前は machine_work.def.name、燃料は test.machine.fuel ÷ 100(燃料の消費量100の処理で何回分か)

$data modify storage test: machine_work.status set value {label:"$(label)",color:"$(color)",name:"",fuel:0}
data modify storage test: machine_work.status.name set from storage test: machine_work.def.name
execute store result storage test: machine_work.status.fuel int 1 run scoreboard players operation #machine_fuel_show test.temporary = @s test.machine.fuel
execute store result storage test: machine_work.status.fuel int 1 run scoreboard players operation #machine_fuel_show test.temporary /= #100 test.constant
function test:machine/status_label with storage test: machine_work.status
execute on passengers if entity @s[tag=machine_label] run function test:machine/status_set with storage test: machine_work.status
return 1
