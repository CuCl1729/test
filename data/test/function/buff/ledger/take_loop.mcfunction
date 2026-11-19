#> test:buff/ledger/take_loop
# @macro = buff_ledger.arg。work.in のうち指定した付与元の段だけ終了イベントへ回し、
# ほかの段は順番どおり work.out へ残す

execute unless data storage test: buff_ledger.work.in[0] run return 0

data modify storage test: buff_ledger.work.u set from storage test: buff_ledger.work.in[0]
data remove storage test: buff_ledger.work.in[0]

$execute if data storage test: buff_ledger.work.u{src:"$(src)"} run function test:buff/ledger/occ with storage test: buff_ledger.work.ev
$execute unless data storage test: buff_ledger.work.u{src:"$(src)"} run data modify storage test: buff_ledger.work.out append from storage test: buff_ledger.work.u

function test:buff/ledger/take_loop with storage test: buff_ledger.arg
