#> test:buff/ledger/advance_timer_loop
# work.u のタイマー先頭が経過時間を過ぎていれば1回だけ積んで取り除く。
# 1ステップで複数のタイマー地点を跨いだ場合は、跨いだぶんすべて発火する(それぞれ別の機会)。
# 機会はこのステップの何秒目に鳴ったか(n = 予定時刻 - 進める前の経過時間)で区別する。
# 同じ秒に鳴ったものは年齢が違ってもまとめ、違う秒に鳴ったものは何回目の跨ぎでも分ける

execute unless data storage test: buff_ledger.work.u.timers[0] run return 0

scoreboard players set #lg_at test.buff.work 0
execute store result score #lg_at test.buff.work run data get storage test: buff_ledger.work.u.timers[0]
execute if score #lg_at test.buff.work > #lg_el test.buff.work run return 0

data remove storage test: buff_ledger.work.u.timers[0]
scoreboard players operation #lg_n test.buff.work = #lg_at test.buff.work
scoreboard players operation #lg_n test.buff.work -= #lg_el0 test.buff.work

data modify storage test: buff_ledger.work.ev set value {event:"timer",reason:"tick"}
data modify storage test: buff_ledger.work.ev.id set from storage test: buff_ledger.work.g.id
function test:buff/ledger/occ with storage test: buff_ledger.work.ev
execute store result storage test: buff_ledger.work.occ[-1].n int 1 run scoreboard players get #lg_n test.buff.work
execute store result storage test: buff_ledger.work.occ[-1].unit.at int 1 run scoreboard players get #lg_at test.buff.work

# 段ごとに積むと秒の順番がばらけるので、並べ替え待ちへ移す(o = 鳴った秒)
data modify storage test: buff_ledger.work.tocc append from storage test: buff_ledger.work.occ[-1]
data remove storage test: buff_ledger.work.occ[-1]
execute store result storage test: buff_ledger.work.tocc[-1].o int 1 run scoreboard players get #lg_n test.buff.work

function test:buff/ledger/advance_timer_loop
