#> test:machine/shape/casing
# 実行位置 = 筐体のブロック。最初の筐体でこの機械の筐体の種類(machine_work.casing)を決め、2つ目からは同じ種類かを調べる
# (違えば #machine_mixed を増やす)

execute if data storage test: machine_work{casing:""} run function test:machine/shape/casing_find
function test:machine/shape/casing_same with storage test: machine_work.casing_def
return 1
