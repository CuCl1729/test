#> test:buff/runtime/arg_create
# 内部。grant / maintain の台帳引数を組む。eff はこの時点では空の置き場で、
# 台帳が実際に新しい連番を出したときだけ freeze が押す。
# 継続時間は arg の上書き > レジストリ。段数の上限・周期・一度きりのタイマーはレジストリの写し
# (無いキーは作らない。上限だけは台帳の約束どおり最低1段)

data modify storage test: buff_ledger.arg set value {count:1,src:"-",caster:-1,max_stacks:1,policy:"independent",eff:{}}
data modify storage test: buff_ledger.arg.id set from storage test: buff_runtime.work.arg.id
execute store result storage test: buff_ledger.arg.seq int 1 run scoreboard players get #rt_oldseq test.buff.work

execute if data storage test: buff_runtime.work.arg.count run data modify storage test: buff_ledger.arg.count set from storage test: buff_runtime.work.arg.count
execute if data storage test: buff_runtime.work.arg.src run data modify storage test: buff_ledger.arg.src set from storage test: buff_runtime.work.arg.src
execute if data storage test: buff_runtime.work.arg.caster run data modify storage test: buff_ledger.arg.caster set from storage test: buff_runtime.work.arg.caster
execute if data storage test: buff_runtime.work.arg.initial run data modify storage test: buff_ledger.arg.initial set from storage test: buff_runtime.work.arg.initial

execute if data storage test: buff_runtime.work.def.duration run data modify storage test: buff_ledger.arg.duration set from storage test: buff_runtime.work.def.duration
execute if data storage test: buff_runtime.work.arg.duration run data modify storage test: buff_ledger.arg.duration set from storage test: buff_runtime.work.arg.duration
execute if data storage test: buff_runtime.work.def.max_stacks run data modify storage test: buff_ledger.arg.max_stacks set from storage test: buff_runtime.work.def.max_stacks
execute if data storage test: buff_runtime.work.def.stack_lifetime run data modify storage test: buff_ledger.arg.policy set from storage test: buff_runtime.work.def.stack_lifetime
execute if data storage test: buff_runtime.work.def.interval run data modify storage test: buff_ledger.arg.interval set from storage test: buff_runtime.work.def.interval
execute if data storage test: buff_runtime.work.def.timers run data modify storage test: buff_ledger.arg.timers set from storage test: buff_runtime.work.def.timers

# 維持更新は残っている段の付与者・固定した数値を据え置く(新しい連番が出ないときは freeze を呼ばないので、
# ここで空の置き場や既定の付与者を書き込ませると凍結済みの写しが消える)
execute if data storage test: buff_runtime.work.arg{op:"maintain"} run data modify storage test: buff_ledger.arg.preserve_snapshot set value 1b
