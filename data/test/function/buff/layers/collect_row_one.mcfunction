#> test:buff/layers/collect_row_one
# @macro stat/value
# modeごとにacc.<stat>.add/flat/mへ積む。mはreference_flatが立っていてもflatへは入れない(仕様通り)
$execute unless data storage test: buff_layers.work.acc.$(stat) run data modify storage test: buff_layers.work.acc.$(stat) set value {add:[],flat:[],m:[]}
$execute if data storage test: buff_layers.work.row{mode:"add"} run data modify storage test: buff_layers.work.acc.$(stat).add append value {stat:"u",percent:$(value)}
$execute if data storage test: buff_layers.work.row{mode:"add",reference_flat:1b} run data modify storage test: buff_layers.work.acc.$(stat).flat append value {stat:"u",percent:$(value)}
$execute if data storage test: buff_layers.work.row{mode:"m"} run data modify storage test: buff_layers.work.acc.$(stat).m append value {stat:"u",percent:$(value)}
