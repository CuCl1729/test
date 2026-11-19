#> test:buff/migrate
# @s = 受け手。古い形式(.test.buff の一覧だけがあり、正本の .test.buff_state が無い)のバフを、
# 新しい台帳へ1度だけ移す。古い一覧の各バフを、残り時間と付与元(src のキー)を保ったまま付け直す
# (付与者の記録は古い形式に無いので、付与者なし)。呼び出し元の buff_runtime.arg は戻す。
# 古い仕組みが入れた速度・跳躍の修飾子は、新しい仕組みが入れたものとして覚えさせ、合計に合わせて入れ直す。
# 古い仕組みが得点に足した test.buff.<名前> は、新しい台帳が付け直すたびに合計から上書きされる
function #oh_my_dat:please
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff_state run return 0
execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff[0] run return 0

data modify storage test: buff_work.mig set value {}
execute if data storage test: buff_runtime.arg run data modify storage test: buff_work.mig.arg set from storage test: buff_runtime.arg
data modify storage test: buff_work.mig.list set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff
execute if data storage test: buff_work.mig.list[{id:"speed_up"}] run data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff_native.speed set value 1b
execute if data storage test: buff_work.mig.list[{id:"jump_up"}] run data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff_native.jump set value 1b
data remove storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff
data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff_state set value {version:2,next_seq:1,ledger:[]}

function test:buff/migrate_loop
function test:buff/native/reconcile

data remove storage test: buff_runtime.arg
execute if data storage test: buff_work.mig.arg run data modify storage test: buff_runtime.arg set from storage test: buff_work.mig.arg
data remove storage test: buff_work.mig
return 1
