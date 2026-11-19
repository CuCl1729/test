#> test:buff/layers/sum
# work.sumtermsをeval/signedへ丸投げして正確な符号付き合計を取る(u:10000は単位refなのでfloor(Σpercent·10000/10000)=Σpercentと一致する)
data modify storage test: buff_eval.arg set value {terms:[],flat:0,refs:{u:10000}}
data modify storage test: buff_eval.arg.terms set from storage test: buff_layers.work.sumterms
function test:buff/eval/signed
scoreboard players set #bl_v test.buff.work 0
execute if data storage test: buff_eval.result{ok:0b} run scoreboard players set #bl_err test.buff.work 1
execute if data storage test: buff_eval.result{ok:1b} run execute store result score #bl_v test.buff.work run data get storage test: buff_eval.result.value
