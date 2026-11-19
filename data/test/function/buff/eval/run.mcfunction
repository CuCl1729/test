#> test:buff/eval/run
# evaluateとsignedの共通本体。#be_signedで公開/内部の挙動差(sign・maxの無視)を切り替える

scoreboard players set #be_100 test.buff.work 100
scoreboard players set #be_neg1 test.buff.work -1
scoreboard players set #be_err test.buff.work 0

scoreboard players set #be_a0 test.buff.work 0
scoreboard players set #be_a1 test.buff.work 0
scoreboard players set #be_a2 test.buff.work 0
scoreboard players set #be_a3 test.buff.work 0
scoreboard players set #be_a4 test.buff.work 0
scoreboard players set #be_a5 test.buff.work 0
scoreboard players set #be_a6 test.buff.work 0
scoreboard players set #be_a7 test.buff.work 0
scoreboard players set #be_a8 test.buff.work 0
scoreboard players set #be_a9 test.buff.work 0
scoreboard players set #be_a10 test.buff.work 0
scoreboard players set #be_a11 test.buff.work 0
scoreboard players set #be_a12 test.buff.work 0

data modify storage test: buff_eval.work set value {terms:[],refs:{}}
execute if data storage test: buff_eval.arg.terms run data modify storage test: buff_eval.work.terms set from storage test: buff_eval.arg.terms
execute if data storage test: buff_eval.arg.refs run data modify storage test: buff_eval.work.refs set from storage test: buff_eval.arg.refs

execute store result score #be_flat test.buff.work run data get storage test: buff_eval.arg.flat

scoreboard players set #be_sign test.buff.work 1
execute if score #be_signed test.buff.work matches 0 if data storage test: buff_eval.arg.sign run execute store result score #be_sign test.buff.work run data get storage test: buff_eval.arg.sign

scoreboard players set #be_has_max test.buff.work 0
execute if score #be_signed test.buff.work matches 0 if data storage test: buff_eval.arg.max run scoreboard players set #be_has_max test.buff.work 1
execute if score #be_signed test.buff.work matches 0 if data storage test: buff_eval.arg.max run execute store result score #be_max test.buff.work run data get storage test: buff_eval.arg.max

# 項が無ければ加算器は全桁0のままなので、flatだけでfinishへ直行して良い
execute unless data storage test: buff_eval.work.terms[0] run return run function test:buff/eval/finish

function test:buff/eval/term_loop

execute unless score #be_err test.buff.work matches 1 run function test:buff/eval/finish
execute if score #be_err test.buff.work matches 1 run data modify storage test: buff_eval.result set value {ok:0b,error:"missing_reference"}
execute if score #be_err test.buff.work matches 1 run data remove storage test: buff_eval.work
