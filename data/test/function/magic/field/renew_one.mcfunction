#> test:magic/field/renew_one
# @s = 場の中に居続けている者。@macro id: この場が掛けたバフ。
# この場の名前のぶんを維持する(段数は増やさず、付与時イベントも出さない。ほかの付与元に押し出されて
# 減っていれば、上限が空いたときだけ足りないぶんを補う)。段数はこの場が掛けるはずの段数
data remove storage test: buff_work.src_arg
$data modify storage test: buff_work.src_arg set value {id:"$(id)",stacks:1,key:"f0",duration:1,initial:0b}
data modify storage test: buff_work.src_arg.duration set from storage test: field_work.secs
function test:magic/field/src_key with storage test: field_work
$execute if data storage test: field_work.pending[{id:"$(id)"}].stacks run data modify storage test: buff_work.src_arg.stacks set from storage test: field_work.pending[{id:"$(id)"}].stacks
function test:buff/apply_source with storage test: buff_work.src_arg
