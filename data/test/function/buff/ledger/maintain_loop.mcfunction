#> test:buff/ledger/maintain_loop
# @macro = buff_ledger.arg。work.in の段を順番どおり work.out へ移しながら、
# 同じ付与元の段だけ入れ直す。終わらせる段(#lg_drop)は積み直さない

execute unless data storage test: buff_ledger.work.in[0] run return 0

data modify storage test: buff_ledger.work.u set from storage test: buff_ledger.work.in[0]
data remove storage test: buff_ledger.work.in[0]

$execute if data storage test: buff_ledger.work.u{src:"$(src)"} run function test:buff/ledger/maintain_one with storage test: buff_ledger.arg

execute if score #lg_drop test.buff.work matches 0 run data modify storage test: buff_ledger.work.out append from storage test: buff_ledger.work.u
scoreboard players set #lg_drop test.buff.work 0

function test:buff/ledger/maintain_loop with storage test: buff_ledger.arg
