#> test:machine/shape/loop
# @s = 機械のマーカー。machine_work.parts(定義の parts のコピー)を1つずつ判定する

execute unless data storage test: machine_work.parts[0] run return 0
function test:machine/shape/part with storage test: machine_work.parts[0]
data remove storage test: machine_work.parts[0]
function test:machine/shape/loop
