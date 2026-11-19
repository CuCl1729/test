#> test:buff/ledger/advance
# @macro = buff_ledger.arg {step}。step 秒ぶん時間を進める。
# (リアルタイムは1秒ごとに1、ターン制は手番終了時に10。継続時間を常に「秒」で持つことで
#  「ターン制の継続時間 = アクション制の秒数/10手番」が換算処理なしで成り立つ)
# 0以下は何もしない(同じ手番を二重に進めて周期を余計に発火させないため)

function test:buff/ledger/begin

scoreboard players set #lg_step test.buff.work 0
$scoreboard players set #lg_step test.buff.work $(step)
execute if score #lg_step test.buff.work matches ..0 run return run function test:buff/ledger/end

data modify storage test: buff_ledger.work.groups set from storage test: buff_ledger.ledger
data modify storage test: buff_ledger.ledger set value []
function test:buff/ledger/advance_group_loop

function test:buff/ledger/end
