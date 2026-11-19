#> test:buff/runtime/freeze
# 内部。@s = 受け手。台帳が新しく出した連番の段に、掛けた時点の発生元で固定した eff を押す。
# prepare は1回だけ呼ぶ。成功で 1、断られたら理由を work.err に入れて 0
# (生き残った古い段は作り直さない。発生元の参照値が変わっても古い写しは動かさないため)

data modify storage test: buff_prepare.arg set value {caster:-1}
data modify storage test: buff_prepare.arg.id set from storage test: buff_runtime.work.arg.id
execute if data storage test: buff_runtime.work.arg.caster run data modify storage test: buff_prepare.arg.caster set from storage test: buff_runtime.work.arg.caster
execute if data storage test: buff_runtime.work.arg.caster_uuid run data modify storage test: buff_prepare.arg.caster_uuid set from storage test: buff_runtime.work.arg.caster_uuid
execute if data storage test: buff_runtime.work.arg.last_refs run data modify storage test: buff_prepare.arg.last_refs set from storage test: buff_runtime.work.arg.last_refs
function test:buff/prepare

execute if data storage test: buff_prepare.result{ok:0b} run data modify storage test: buff_runtime.work.err set from storage test: buff_prepare.result.error
execute if data storage test: buff_prepare.result{ok:0b} run return 0

# eff は丸ごと写すので、prepare が入れた発生元の身元(caster_uuid)もそのまま残る。
# eff は効果行だけでなく、そのとき確定した params と参照値も凍結して持つ
# (prepare は params / refs を eff の外に返すので、ここで中へ入れる)
data modify storage test: buff_runtime.work.eff set from storage test: buff_prepare.result.eff
data modify storage test: buff_runtime.work.eff.params set from storage test: buff_prepare.result.params
data modify storage test: buff_runtime.work.eff.refs set from storage test: buff_prepare.result.refs

data modify storage test: buff_runtime.work.stamp set value {}
data modify storage test: buff_runtime.work.stamp.id set from storage test: buff_runtime.work.arg.id
scoreboard players operation #rt_seq test.buff.work = #rt_oldseq test.buff.work
function test:buff/runtime/stamp_loop
return 1
