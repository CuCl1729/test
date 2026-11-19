#> test:buff/layers/collect_unit_loop
# work.usを先頭から1件ずつ消費する

execute unless data storage test: buff_layers.work.us[0] run return 0

data modify storage test: buff_layers.work.u set from storage test: buff_layers.work.us[0]
data remove storage test: buff_layers.work.us[0]

# effectsが無いunitもあるので[]を既定にしてから上書きする
data modify storage test: buff_layers.work.rows set value []
execute if data storage test: buff_layers.work.u.eff.effects run data modify storage test: buff_layers.work.rows set from storage test: buff_layers.work.u.eff.effects

function test:buff/layers/collect_row_loop

function test:buff/layers/collect_unit_loop
