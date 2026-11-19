#> test:buff/ledger/clear_loop
# 台帳を先頭から1バフずつ取り崩す(表示順のままイベントが並ぶ)

execute unless data storage test: buff_ledger.ledger[0] run return 0

data modify storage test: buff_ledger.work.ev set value {event:"expire",reason:"remove"}
data modify storage test: buff_ledger.work.ev.id set from storage test: buff_ledger.ledger[0].id
data modify storage test: buff_ledger.work.in set from storage test: buff_ledger.ledger[0].units
data remove storage test: buff_ledger.ledger[0]
function test:buff/ledger/drop_loop

function test:buff/ledger/clear_loop
