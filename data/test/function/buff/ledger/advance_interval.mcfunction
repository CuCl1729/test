#> test:buff/ledger/advance_interval
# 繰り返しイベントを1回だけ積み、次回の発火時刻を経過時間の先へ進める。
# ターン制は1手番で10秒進むため、interval が10以下のバフは毎手番きっちり1回の発火になる。
# 1回の処理につき1回までなので機会は常に n:1。段ごとの発火年齢は内訳の at に残す

scoreboard players set #lg_next test.buff.work 0
execute store result score #lg_next test.buff.work run data get storage test: buff_ledger.work.u.next_interval
execute unless score #lg_next test.buff.work matches 1.. run return 0
execute unless score #lg_next test.buff.work <= #lg_el test.buff.work run return 0

data modify storage test: buff_ledger.work.ev set value {event:"interval",reason:"tick"}
data modify storage test: buff_ledger.work.ev.id set from storage test: buff_ledger.work.g.id
function test:buff/ledger/occ with storage test: buff_ledger.work.ev
execute store result storage test: buff_ledger.work.occ[-1].unit.at int 1 run scoreboard players get #lg_el test.buff.work

# 繰り返しはそのステップで1回だけなので、鳴ったタイマーのあと・終了の前に置く
data modify storage test: buff_ledger.work.tocc append from storage test: buff_ledger.work.occ[-1]
data remove storage test: buff_ledger.work.occ[-1]
data modify storage test: buff_ledger.work.tocc[-1].o set value 2147483647

scoreboard players set #lg_int test.buff.work 0
execute store result score #lg_int test.buff.work run data get storage test: buff_ledger.work.u.interval
execute if score #lg_int test.buff.work matches ..0 run scoreboard players set #lg_int test.buff.work 1
function test:buff/ledger/advance_interval_advance

execute store result storage test: buff_ledger.work.u.next_interval int 1 run scoreboard players get #lg_next test.buff.work
