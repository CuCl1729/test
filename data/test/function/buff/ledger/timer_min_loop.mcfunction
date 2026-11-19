#> test:buff/ledger/timer_min_loop
# 残っている中でいちばん早い秒を #lg_min に取る

execute unless data storage test: buff_ledger.work.scan[0] run return 0

scoreboard players set #lg_o test.buff.work 2147483647
execute store result score #lg_o test.buff.work run data get storage test: buff_ledger.work.scan[0].o
data remove storage test: buff_ledger.work.scan[0]
execute if score #lg_o test.buff.work < #lg_min test.buff.work run scoreboard players operation #lg_min test.buff.work = #lg_o test.buff.work

function test:buff/ledger/timer_min_loop
