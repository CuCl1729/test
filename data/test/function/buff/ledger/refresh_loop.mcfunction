#> test:buff/ledger/refresh_loop
# @macro = buff_ledger.arg。work.in の段を順番どおり work.out へ移しながら残り時間だけ戻す

execute unless data storage test: buff_ledger.work.in[0] run return 0

data modify storage test: buff_ledger.work.out append from storage test: buff_ledger.work.in[0]
data remove storage test: buff_ledger.work.in[0]
$data modify storage test: buff_ledger.work.out[-1].remaining set value $(duration)

function test:buff/ledger/refresh_loop with storage test: buff_ledger.arg
