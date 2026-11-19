#> test:buff/layers/evaluate
# 公開エントリ。収集→発行の順で一度だけresultを書く。失敗時でも部分書き込みが残らない
scoreboard players set #bl_err test.buff.work 0
data modify storage test: buff_layers.work set value {ledger:[],passives:[],acc:{},out:{ok:1b,stats:{},refs:{},add:{},m:{},flat:{}}}
execute if data storage test: buff_layers.arg.ledger run data modify storage test: buff_layers.work.ledger set from storage test: buff_layers.arg.ledger
execute if data storage test: buff_layers.arg.passives run data modify storage test: buff_layers.work.passives set from storage test: buff_layers.arg.passives
function test:buff/layers/collect_loop
function test:buff/layers/emit_loop
execute if score #bl_err test.buff.work matches 1 run data modify storage test: buff_layers.result set value {ok:0b,error:"out_of_range"}
execute unless score #bl_err test.buff.work matches 1 run data modify storage test: buff_layers.result set from storage test: buff_layers.work.out
data remove storage test: buff_layers.work
data remove storage test: buff_eval.arg
data remove storage test: buff_eval.result
