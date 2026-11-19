#> test:buff/ledger/remove_source
# @macro = buff_ledger.arg {id,src}。その付与元が付けた段だけを取り消す。
# ほかの付与元(ふつうの付与 "-" や別の場、別の付与者の同じバフ)の段数・残り時間・時計はそのまま。
# 効果時間の更新方式に関係なく働く

function test:buff/ledger/begin

$execute unless data storage test: buff_ledger.ledger[{id:"$(id)"}] run return run function test:buff/ledger/end

data modify storage test: buff_ledger.work.ev set value {event:"expire",reason:"remove"}
data modify storage test: buff_ledger.work.ev.id set from storage test: buff_ledger.arg.id

$data modify storage test: buff_ledger.work.in set from storage test: buff_ledger.ledger[{id:"$(id)"}].units
data modify storage test: buff_ledger.work.out set value []
function test:buff/ledger/take_loop with storage test: buff_ledger.arg
$data modify storage test: buff_ledger.ledger[{id:"$(id)"}].units set from storage test: buff_ledger.work.out

$execute unless data storage test: buff_ledger.ledger[{id:"$(id)"}].units[0] run data remove storage test: buff_ledger.ledger[{id:"$(id)"}]

function test:buff/ledger/end
