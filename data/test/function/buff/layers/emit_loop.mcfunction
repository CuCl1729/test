#> test:buff/layers/emit_loop
# work.passivesを先頭から1件ずつ消費してemit_oneへ渡す。エラーが立ったら即座に抜ける

execute unless data storage test: buff_layers.work.passives[0] run return 0

data modify storage test: buff_layers.work.p set from storage test: buff_layers.work.passives[0]
data remove storage test: buff_layers.work.passives[0]

function test:buff/layers/emit_one with storage test: buff_layers.work.p

execute if score #bl_err test.buff.work matches 1 run return 0

function test:buff/layers/emit_loop
