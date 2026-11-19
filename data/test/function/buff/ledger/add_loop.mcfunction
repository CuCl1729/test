#> test:buff/ledger/add_loop
# @macro = buff_ledger.arg。#lg_new 段ぶん、本当に新しい段を末尾(=一番新しい)へ足して apply を積む。
# 固定した効果値(eff)は評価済みのものをそのまま写す。ここでは計算も付与者の参照もしない

execute if score #lg_new test.buff.work matches ..0 run return 0

$data modify storage test: buff_ledger.work.u set value {seq:0,src:"$(src)",caster:$(caster),remaining:$(duration),elapsed:0}
execute store result storage test: buff_ledger.work.u.seq int 1 run scoreboard players get #lg_seq test.buff.work
execute if data storage test: buff_ledger.arg.eff run data modify storage test: buff_ledger.work.u.eff set from storage test: buff_ledger.arg.eff
execute if data storage test: buff_ledger.arg.interval run data modify storage test: buff_ledger.work.u.interval set from storage test: buff_ledger.arg.interval
execute if data storage test: buff_ledger.arg.interval run data modify storage test: buff_ledger.work.u.next_interval set from storage test: buff_ledger.arg.interval
execute if data storage test: buff_ledger.arg.timers run data modify storage test: buff_ledger.work.u.timers set from storage test: buff_ledger.arg.timers

$data modify storage test: buff_ledger.ledger[{id:"$(id)"}].units append from storage test: buff_ledger.work.u
# 継続中の維持更新(initial:0b)で埋め直した段は、付与時イベントを出さない。
# 付与時イベントはその場に入った初回だけ
execute if score #lg_quiet test.buff.work matches 0 run function test:buff/ledger/occ with storage test: buff_ledger.work.ev

scoreboard players add #lg_seq test.buff.work 1
scoreboard players remove #lg_new test.buff.work 1
function test:buff/ledger/add_loop with storage test: buff_ledger.arg
