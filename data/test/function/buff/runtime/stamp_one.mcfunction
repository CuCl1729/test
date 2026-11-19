#> test:buff/runtime/stamp_one
# 内部。@macro {id,seq}: その連番の段と、対応する apply のイベントの写しに同じ eff を押す。
# 維持の継続ぶん(initial:0b)は apply を出さないので、イベント側は在るときだけ触る
$data modify storage test: buff_ledger.ledger[{id:"$(id)"}].units[{seq:$(seq)}].eff set from storage test: buff_runtime.work.eff
$execute if data storage test: buff_ledger.events[{id:"$(id)",event:"apply"}] run data modify storage test: buff_ledger.events[{id:"$(id)",event:"apply"}].units[{seq:$(seq)}].eff set from storage test: buff_runtime.work.eff
