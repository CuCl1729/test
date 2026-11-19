#> test:buff/migrate_src
# 内部。@s = 受け手。mig.one.src の先頭の内訳 {k, stacks, remaining} を1件付け直す。
# "-" はふつうの付与、それ以外は場のキー(初回扱いにはしない。付与時イベントは古い仕組みで既に出ている)
execute unless data storage test: buff_work.mig.one.src[0] run return 0
data modify storage test: buff_work.mig.cur set from storage test: buff_work.mig.one.src[0]
data remove storage test: buff_work.mig.one.src[0]

data modify storage test: buff_runtime.arg set value {op:"grant",count:1,duration:1}
execute unless data storage test: buff_work.mig.cur{k:"-"} run data modify storage test: buff_runtime.arg.op set value "maintain"
execute unless data storage test: buff_work.mig.cur{k:"-"} run data modify storage test: buff_runtime.arg.initial set value 0b
execute unless data storage test: buff_work.mig.cur{k:"-"} run data modify storage test: buff_runtime.arg.src set from storage test: buff_work.mig.cur.k
data modify storage test: buff_runtime.arg.id set from storage test: buff_work.mig.one.id
data modify storage test: buff_runtime.arg.count set from storage test: buff_work.mig.cur.stacks
data modify storage test: buff_runtime.arg.duration set from storage test: buff_work.mig.cur.remaining
function test:buff/events/submit
function #oh_my_dat:please
function test:buff/migrate_src
