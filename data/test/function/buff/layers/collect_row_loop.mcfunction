#> test:buff/layers/collect_row_loop
# work.rowsを先頭から1件ずつ消費する。kind:"stat"以外はstat/valueを持たずマクロ展開に失敗するため、ここで絞る

execute unless data storage test: buff_layers.work.rows[0] run return 0

data modify storage test: buff_layers.work.row set from storage test: buff_layers.work.rows[0]
data remove storage test: buff_layers.work.rows[0]

execute if data storage test: buff_layers.work.row{kind:"stat"} run function test:buff/layers/collect_row_one with storage test: buff_layers.work.row

function test:buff/layers/collect_row_loop
