#> test:buff/ledger/advance_unit_loop
# work.in の段を1件ずつ進める。段ごとに残り時間が独立しているので、
# 片方の付与元が切れても、もう一方はそのまま続く

execute unless data storage test: buff_ledger.work.in[0] run return 0

data modify storage test: buff_ledger.work.u set from storage test: buff_ledger.work.in[0]
data remove storage test: buff_ledger.work.in[0]

scoreboard players set #lg_rem test.buff.work 0
scoreboard players set #lg_el test.buff.work 0
execute store result score #lg_rem test.buff.work run data get storage test: buff_ledger.work.u.remaining
execute store result score #lg_el test.buff.work run data get storage test: buff_ledger.work.u.elapsed
# 進める前の経過時間。タイマーが「このステップの何秒目に鳴ったか」を出すのに使う
scoreboard players operation #lg_el0 test.buff.work = #lg_el test.buff.work
scoreboard players operation #lg_rem test.buff.work -= #lg_step test.buff.work
scoreboard players operation #lg_el test.buff.work += #lg_step test.buff.work
execute store result storage test: buff_ledger.work.u.remaining int 1 run scoreboard players get #lg_rem test.buff.work
execute store result storage test: buff_ledger.work.u.elapsed int 1 run scoreboard players get #lg_el test.buff.work

# 一度きりのタイマー: 経過時間を越えたぶんをすべて(昇順に並んでいる前提)
execute if data storage test: buff_ledger.work.u.timers[0] run function test:buff/ledger/advance_timer_loop

# 繰り返し: 1ステップにつき最大1回
execute if data storage test: buff_ledger.work.u.next_interval run function test:buff/ledger/advance_interval

execute if score #lg_rem test.buff.work matches 1.. run data modify storage test: buff_ledger.work.out append from storage test: buff_ledger.work.u
execute if score #lg_rem test.buff.work matches ..0 run data modify storage test: buff_ledger.work.exp append from storage test: buff_ledger.work.u

function test:buff/ledger/advance_unit_loop
