#> test:buff/ledger/timer_take_loop
# いちばん早い秒のものだけを occ へ(並び順はそのまま)、残りは tocc へ戻す

execute unless data storage test: buff_ledger.work.scan[0] run return 0

scoreboard players set #lg_o test.buff.work 2147483647
execute store result score #lg_o test.buff.work run data get storage test: buff_ledger.work.scan[0].o
execute if score #lg_o test.buff.work = #lg_min test.buff.work run data modify storage test: buff_ledger.work.occ append from storage test: buff_ledger.work.scan[0]
execute unless score #lg_o test.buff.work = #lg_min test.buff.work run data modify storage test: buff_ledger.work.tocc append from storage test: buff_ledger.work.scan[0]
data remove storage test: buff_ledger.work.scan[0]

function test:buff/ledger/timer_take_loop
