#> test:machine/tick_second
# @s = 機械のマーカー(test:tick の1秒クロックから。実行位置は核の中心。ターン制のアリーナでは呼ばない)。
# 読み込まれているチャンクの機械だけが動く(バニラのかまどと同じ)。
# 1. 核が無ければ(レンチで壊されたら)エッグを落として消える
# 2. 外側の26か所を判定する(test:machine/shape/check)。足りない位置には、近くに人がいればゴースト(ブロックディスプレイ)を出す
# 3. 揃っていなければ止める(進み具合は残す): 未完成 / 筐体が混在 / 搬入口なし / 搬出口なし
# 4. 揃っていれば動かす(test:machine/run)

execute unless score @s test.machine.id matches 1.. run function test:machine/assign_id
scoreboard players add @s test.machine.fuel 0
scoreboard players add @s test.machine.progress 0
scoreboard players add @s test.machine.out_rr 0
scoreboard players operation #machine_owner test.temporary = @s test.machine.id

function test:machine/load_def with entity @s data.machine
execute unless data storage test: machine_work.def.core run return run function test:machine/status {label:"定義なし",color:"red"}

execute store result score #machine_broken test.temporary run function test:machine/check_core with storage test: machine_work.def
execute if score #machine_broken test.temporary matches 1 run return run function test:machine/broken

scoreboard players set #machine_viewer test.temporary 0
execute if entity @a[distance=..16] run scoreboard players set #machine_viewer test.temporary 1
function test:machine/shape/check
function test:machine/ghost/update

execute if score #machine_missing test.temporary matches 1.. run return run function test:machine/status {label:"未完成",color:"red"}
execute if score #machine_mixed test.temporary matches 1.. run return run function test:machine/status {label:"筐体が混在",color:"red"}
execute if score #machine_inputs test.temporary matches 0 run return run function test:machine/status {label:"搬入口なし",color:"red"}
execute if score #machine_outputs test.temporary matches 0 run return run function test:machine/status {label:"搬出口なし",color:"red"}

function test:machine/run
