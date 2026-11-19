#> test:buff/ledger/advance_group_loop
# バフを1件ずつ進める。1段でも残っていれば元の並び順で台帳へ戻す

execute unless data storage test: buff_ledger.work.groups[0] run return 0

data modify storage test: buff_ledger.work.g set from storage test: buff_ledger.work.groups[0]
data remove storage test: buff_ledger.work.groups[0]

data modify storage test: buff_ledger.work.in set from storage test: buff_ledger.work.g.units
data modify storage test: buff_ledger.work.out set value []
data modify storage test: buff_ledger.work.exp set value []
data modify storage test: buff_ledger.work.tocc set value []
function test:buff/ledger/advance_unit_loop

# 鳴ったタイマー(秒の早い順)、そのあと周期
function test:buff/ledger/timer_sort_loop

# 尽きた段の終了は、同じ手番の周期・タイマーより後にまとめる(既存の step_entry と同じ順序)
data modify storage test: buff_ledger.work.ev set value {event:"expire",reason:"expire"}
data modify storage test: buff_ledger.work.ev.id set from storage test: buff_ledger.work.g.id
data modify storage test: buff_ledger.work.in set from storage test: buff_ledger.work.exp
function test:buff/ledger/drop_loop

data modify storage test: buff_ledger.work.g.units set from storage test: buff_ledger.work.out
execute if data storage test: buff_ledger.work.out[0] run data modify storage test: buff_ledger.ledger append from storage test: buff_ledger.work.g

function test:buff/ledger/advance_group_loop
