#> test:buff/ledger/evict_loop
# @macro = buff_ledger.arg。#lg_evict 段ぶん、一番古い段から取り除いて終了イベントを積む

execute if score #lg_evict test.buff.work matches ..0 run return 0

$data modify storage test: buff_ledger.work.u set from storage test: buff_ledger.ledger[{id:"$(id)"}].units[0]
$data remove storage test: buff_ledger.ledger[{id:"$(id)"}].units[0]
function test:buff/ledger/occ with storage test: buff_ledger.work.ev

scoreboard players remove #lg_evict test.buff.work 1
function test:buff/ledger/evict_loop with storage test: buff_ledger.arg
