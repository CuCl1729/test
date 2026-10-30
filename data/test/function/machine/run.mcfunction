#> test:machine/run
# @s = 形が揃った機械のマーカー(実行位置は核の中心、向きは機械の前)。machine_work.def = 機械の定義(+id)。
# 1. 入れ物の中の受け付けないもの(燃料の入れ物の燃料でないもの、原石の入れ物の扱えないもの)を出口へ(自動化の列が詰まらないように)
# 2. 処理中なら1秒進め、終わったら結果を出す
# 3. 処理していなければ、原石を1個取り出して始める(燃料を1回分使う)
# 4. 出すものを出口に落とし、状態を表示する

data modify storage test: machine_work.drop set value []
scoreboard players set #machine_no_fuel test.temporary 0
scoreboard players add @s test.machine.fuel 0
scoreboard players add @s test.machine.progress 0

function test:machine/fuel/clean with storage test: machine_work.def.fuel
function test:machine/input/clean with storage test: machine_work.def.input

execute if data entity @s data.machine.processing run function test:machine/progress
execute unless data entity @s data.machine.processing run function test:machine/start

function test:machine/drop_all with storage test: machine_work.def.output
function test:machine/show
