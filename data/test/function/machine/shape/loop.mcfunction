#> test:machine/shape/loop
# @s = 機械のマーカー。machine_work.shell(asset.machine_shell のコピー)を1か所ずつ判定する

execute unless data storage test: machine_work.shell[0] run return 0
function test:machine/shape/part with storage test: machine_work.shell[0]
data remove storage test: machine_work.shell[0]
function test:machine/shape/loop
