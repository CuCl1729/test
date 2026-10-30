#> test:machine/shape/casing_try
# 実行位置 = 筐体のブロック。@macro id: 筐体の種類。そのブロックなら machine_work.casing / casing_def にする

$data modify storage test: machine_work.casing_try set from storage test: asset.casing.$(id)
$data modify storage test: machine_work.casing_try.id set value "$(id)"
function test:machine/shape/casing_match with storage test: machine_work.casing_try
