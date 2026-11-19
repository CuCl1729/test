#> test:buff/ledger/timer_sort_loop
# 並べ替え待ち(work.tocc)を、鳴った秒(o)の早い順に work.occ へ移す。
# 同じ秒のものは段の並び順のまま。これでバフごとのタイマーが時刻順に並び、
# そのステップで1回だけの繰り返し(o は最大値)が最後に来る

execute unless data storage test: buff_ledger.work.tocc[0] run return 0

scoreboard players set #lg_min test.buff.work 2147483647
data modify storage test: buff_ledger.work.scan set from storage test: buff_ledger.work.tocc
function test:buff/ledger/timer_min_loop

data modify storage test: buff_ledger.work.scan set from storage test: buff_ledger.work.tocc
data modify storage test: buff_ledger.work.tocc set value []
function test:buff/ledger/timer_take_loop

function test:buff/ledger/timer_sort_loop
