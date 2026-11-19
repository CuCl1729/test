#> test:buff/native/reconcile
# @s = 効果を受ける側(受け手。OhMyDatID を持つこと)。
# いまの正本(buff_state version 2)の台帳から合計を出し直し、自分の2つの修飾子だけを入れ直す。
# 正本が無い旧形式では何もしない(旧来の個別コールバックに任せる)ので 0 を返す。
#
#   入れたことを .test.buff_native.{speed,jump} に覚えておく。覚えの無い同名の修飾子は、
#   寄与が無くなっても外さない(他の作者が同じidで入れたものを壊さないため)。
#   他のid(バニラのポーション等)には一切触れない。
#   作業域は buff_native.arg / result / work / attr_arg。buff_work.attr_arg と
#   コールバックの枠・公開イベントの文脈には触れない

function #oh_my_dat:please
execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff_state{version:2} run return 0

data modify storage test: buff_native.arg set value {ledger:[]}
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff_state.ledger[0] run data modify storage test: buff_native.arg.ledger set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff_state.ledger
execute store result score #bn_ok test.buff.work run function test:buff/native/evaluate
execute if score #bn_ok test.buff.work matches 0 run return 0

# 移動速度。per_stack は内部の100倍値で percent なのでさらに÷100(apply と同じ目盛り)
data modify storage test: buff_native.attr_arg set value {attribute:"minecraft:movement_speed",modifier:"test:speed_up",operation:"add_multiplied_total",amount:0.0d}
execute if data storage test: buff_native.result{speed_present:1b} store result storage test: buff_native.attr_arg.amount double 0.0001 run data get storage test: buff_native.result.speed
execute if data storage test: buff_native.result{speed_present:1b} run function test:buff/attribute/add with storage test: buff_native.attr_arg
execute if data storage test: buff_native.result{speed_present:1b} run data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff_native.speed set value 1b
execute if data storage test: buff_native.result{speed_present:0b} if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff_native{speed:1b} run function test:buff/attribute/remove with storage test: buff_native.attr_arg
execute if data storage test: buff_native.result{speed_present:0b} run data remove storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff_native.speed

# ジャンプ強度。表示の単位がそのまま add_value の量(per_stack は内部の100倍値なので÷100)
data modify storage test: buff_native.attr_arg set value {attribute:"minecraft:jump_strength",modifier:"test:jump_up",operation:"add_value",amount:0.0d}
execute if data storage test: buff_native.result{jump_present:1b} store result storage test: buff_native.attr_arg.amount double 0.01 run data get storage test: buff_native.result.jump
execute if data storage test: buff_native.result{jump_present:1b} run function test:buff/attribute/add with storage test: buff_native.attr_arg
execute if data storage test: buff_native.result{jump_present:1b} run data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff_native.jump set value 1b
execute if data storage test: buff_native.result{jump_present:0b} if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff_native{jump:1b} run function test:buff/attribute/remove with storage test: buff_native.attr_arg
execute if data storage test: buff_native.result{jump_present:0b} run data remove storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff_native.jump

return 1
