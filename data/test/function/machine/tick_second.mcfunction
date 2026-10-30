#> test:machine/tick_second
# @s = 機械のマーカー(test:tick の1秒クロックから。実行位置・向きも@s。ターン制のアリーナでは呼ばない)。
# 読み込まれているチャンクの機械だけが動く(バニラのかまどと同じ)。
# 1. 核が無ければ(レンチで壊されたら)エッグを落として消える
# 2. 形(parts)を判定し、揃っていなければ「未完成」で止める(進み具合は残す)。近くに人がいれば足りない位置にパーティクル
# 3. 揃っていれば動かす(test:machine/run: 燃料・搬入・加工・出口・状態の表示)

function test:machine/load_def with entity @s data.machine
execute unless data storage test: machine_work.def.core run return run function test:machine/status {label:"定義なし",color:"red"}

execute store result score #machine_broken test.temporary run function test:machine/check_core with storage test: machine_work.def
execute if score #machine_broken test.temporary matches 1 run return run function test:machine/broken

scoreboard players set #machine_missing test.temporary 0
scoreboard players set #machine_viewer test.temporary 0
execute if entity @a[distance=..16] run scoreboard players set #machine_viewer test.temporary 1
data modify storage test: machine_work.parts set from storage test: machine_work.def.parts
function test:machine/shape/loop
execute if score #machine_missing test.temporary matches 1.. run return run function test:machine/status {label:"未完成",color:"red"}

function test:machine/run
