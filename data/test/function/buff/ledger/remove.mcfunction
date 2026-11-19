#> test:buff/ledger/remove
# @macro = buff_ledger.arg {id}。そのバフの段をすべて取り消す。ほかのバフには触らない

function test:buff/ledger/begin

$execute unless data storage test: buff_ledger.ledger[{id:"$(id)"}] run return run function test:buff/ledger/end

data modify storage test: buff_ledger.work.ev set value {event:"expire",reason:"remove"}
data modify storage test: buff_ledger.work.ev.id set from storage test: buff_ledger.arg.id

$data modify storage test: buff_ledger.work.in set from storage test: buff_ledger.ledger[{id:"$(id)"}].units
function test:buff/ledger/drop_loop
$data remove storage test: buff_ledger.ledger[{id:"$(id)"}]

function test:buff/ledger/end
