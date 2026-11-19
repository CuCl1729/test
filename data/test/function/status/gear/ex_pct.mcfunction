#> test:status/gear/ex_pct
# 内部。今の参照値(ex.v / ex.i)に ex.p の係数を一つずつ掛けた項を作る。0 の係数は飛ばす
execute unless data storage test: status_gear.ex.p[0] run return 0
data modify storage test: status_gear.ex.c set from storage test: status_gear.ex.p[0]
data remove storage test: status_gear.ex.p[0]
execute store result score #gear_t test.buff.work run data get storage test: status_gear.ex.c
execute unless score #gear_t test.buff.work matches 0..0 run function test:status/gear/ex_term with storage test: status_gear.ex
function test:status/gear/ex_pct
