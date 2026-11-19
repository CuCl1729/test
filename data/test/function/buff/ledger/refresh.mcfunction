#> test:buff/ledger/refresh
# @macro = buff_ledger.arg。refresh_all 用。別の付与元の段も含めて残り時間だけを戻す。
# 付与元・付与者・固定した数値・経過時間・周期・タイマー・連番には一切触らない。
# 時間を戻すだけなので、ここでは終了も発生しない(既に捨てた段も戻らない)

execute if score #lg_new test.buff.work matches ..0 run return 0

$data modify storage test: buff_ledger.work.in set from storage test: buff_ledger.ledger[{id:"$(id)"}].units
data modify storage test: buff_ledger.work.out set value []
function test:buff/ledger/refresh_loop with storage test: buff_ledger.arg
$data modify storage test: buff_ledger.ledger[{id:"$(id)"}].units set from storage test: buff_ledger.work.out
