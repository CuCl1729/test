#> test:buff/layers/emit_one
# @macro stat/value
# 寄与する行が無いstatは即座にP直送りで終える。limb演算は一切動かさない
$execute unless data storage test: buff_layers.work.acc.$(stat) run data modify storage test: buff_layers.work.out.stats.$(stat) set value $(value)
$execute unless data storage test: buff_layers.work.acc.$(stat) run data modify storage test: buff_layers.work.out.refs.$(stat) set value $(value)
$execute unless data storage test: buff_layers.work.acc.$(stat) run data modify storage test: buff_layers.work.out.add.$(stat) set value 0
$execute unless data storage test: buff_layers.work.acc.$(stat) run data modify storage test: buff_layers.work.out.m.$(stat) set value 0
$execute unless data storage test: buff_layers.work.acc.$(stat) run data modify storage test: buff_layers.work.out.flat.$(stat) set value 0
$execute unless data storage test: buff_layers.work.acc.$(stat) run return 0

# A = add行の正確な合計
$data modify storage test: buff_layers.work.sumterms set from storage test: buff_layers.work.acc.$(stat).add
function test:buff/layers/sum
scoreboard players operation #bl_a test.buff.work = #bl_v test.buff.work
execute if score #bl_err test.buff.work matches 1 run return 0

# R = reference_flatが立ったadd行だけの正確な合計
$data modify storage test: buff_layers.work.sumterms set from storage test: buff_layers.work.acc.$(stat).flat
function test:buff/layers/sum
scoreboard players operation #bl_r test.buff.work = #bl_v test.buff.work
execute if score #bl_err test.buff.work matches 1 run return 0

# M = m行の正確な合計
$data modify storage test: buff_layers.work.sumterms set from storage test: buff_layers.work.acc.$(stat).m
function test:buff/layers/sum
scoreboard players operation #bl_m test.buff.work = #bl_v test.buff.work
execute if score #bl_err test.buff.work matches 1 run return 0

$execute store result storage test: buff_layers.work.out.add.$(stat) int 1 run scoreboard players get #bl_a test.buff.work
$execute store result storage test: buff_layers.work.out.flat.$(stat) int 1 run scoreboard players get #bl_r test.buff.work
$execute store result storage test: buff_layers.work.out.m.$(stat) int 1 run scoreboard players get #bl_m test.buff.work

# refs = P + R
$data modify storage test: buff_eval.arg set value {terms:[{stat:"u",percent:0}],flat:$(value),refs:{u:10000}}
execute store result storage test: buff_eval.arg.terms[0].percent int 1 run scoreboard players get #bl_r test.buff.work
function test:buff/eval/signed
execute if data storage test: buff_eval.result{ok:0b} run scoreboard players set #bl_err test.buff.work 1
execute if score #bl_err test.buff.work matches 1 run return 0
$execute store result storage test: buff_layers.work.out.refs.$(stat) int 1 run data get storage test: buff_eval.result.value

# stats = floor((P+A)*(10000+M)/10000)。P+AもM+10000もスコアに作らず、
# 2つのrefへ各2項(10000とM)で分子を広いまま持ち、最後に一度だけfloorと範囲検査を通す
$data modify storage test: buff_eval.arg set value {terms:[{stat:"p",percent:10000},{stat:"a",percent:10000},{stat:"p",percent:0},{stat:"a",percent:0}],flat:0,refs:{p:$(value),a:0}}
execute store result storage test: buff_eval.arg.refs.a int 1 run scoreboard players get #bl_a test.buff.work
execute store result storage test: buff_eval.arg.terms[2].percent int 1 run scoreboard players get #bl_m test.buff.work
execute store result storage test: buff_eval.arg.terms[3].percent int 1 run scoreboard players get #bl_m test.buff.work
function test:buff/eval/signed
execute if data storage test: buff_eval.result{ok:0b} run scoreboard players set #bl_err test.buff.work 1
execute if score #bl_err test.buff.work matches 1 run return 0
$execute store result storage test: buff_layers.work.out.stats.$(stat) int 1 run data get storage test: buff_eval.result.value
