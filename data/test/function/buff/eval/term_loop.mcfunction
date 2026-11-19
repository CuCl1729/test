#> test:buff/eval/term_loop
# work.termsを先頭から1件ずつ消費する(ledger/fold_loopと同じ消費ループの型)

execute unless data storage test: buff_eval.work.terms[0] run return 0

data modify storage test: buff_eval.work.t set from storage test: buff_eval.work.terms[0]
data remove storage test: buff_eval.work.terms[0]

function test:buff/eval/term_one with storage test: buff_eval.work.t

function test:buff/eval/term_loop
