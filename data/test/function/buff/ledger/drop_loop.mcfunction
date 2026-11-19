#> test:buff/ledger/drop_loop
# work.in の段をすべて work.ev のイベントとして積む(古い段から順)

execute unless data storage test: buff_ledger.work.in[0] run return 0

data modify storage test: buff_ledger.work.u set from storage test: buff_ledger.work.in[0]
data remove storage test: buff_ledger.work.in[0]
function test:buff/ledger/occ with storage test: buff_ledger.work.ev

function test:buff/ledger/drop_loop
