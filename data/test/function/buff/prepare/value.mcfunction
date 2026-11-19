#> test:buff/prepare/value
# 内部。work.row の数値行を既存の eval/evaluate で一度だけ評価して value を足す。
# 小計の0クランプ・行ごとのmax・符号(既定1)は evaluate 側の決まったままで、ここでは何も変えない
# (heal/damage に max は無い。コンパイル時点で禁じてある)

data modify storage test: buff_eval.arg set value {terms:[],flat:0}
data modify storage test: buff_eval.arg.refs set from storage test: buff_prepare.work.refs
execute if data storage test: buff_prepare.work.row.terms run data modify storage test: buff_eval.arg.terms set from storage test: buff_prepare.work.row.terms
execute if data storage test: buff_prepare.work.row.flat run data modify storage test: buff_eval.arg.flat set from storage test: buff_prepare.work.row.flat
execute if data storage test: buff_prepare.work.row.sign run data modify storage test: buff_eval.arg.sign set from storage test: buff_prepare.work.row.sign
execute if data storage test: buff_prepare.work.row.max run data modify storage test: buff_eval.arg.max set from storage test: buff_prepare.work.row.max

function test:buff/eval/evaluate

execute if data storage test: buff_eval.result{ok:1b} run data modify storage test: buff_prepare.work.row.value set from storage test: buff_eval.result.value
execute if data storage test: buff_eval.result{ok:0b} run data modify storage test: buff_prepare.result set value {ok:0b}
execute if data storage test: buff_eval.result{ok:0b} run data modify storage test: buff_prepare.result.error set from storage test: buff_eval.result.error
