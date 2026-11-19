#> test:buff/layers/collect_loop
# work.ledgerを先頭から1件ずつ消費する(eval/term_loopと同じ消費ループの型)

execute unless data storage test: buff_layers.work.ledger[0] run return 0

data modify storage test: buff_layers.work.g set from storage test: buff_layers.work.ledger[0]
data remove storage test: buff_layers.work.ledger[0]

# unitsが無いidもあるので[]を既定にしてから上書きする
data modify storage test: buff_layers.work.us set value []
execute if data storage test: buff_layers.work.g.units run data modify storage test: buff_layers.work.us set from storage test: buff_layers.work.g.units

function test:buff/layers/collect_unit_loop

function test:buff/layers/collect_loop
