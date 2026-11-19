#> test:buff/on/apply/speed_up
# @s = バフ保持者。#buff_stacks test.buff.work に付与後のスタック数が入っている
# 1スタックにつき移動速度+per_stack%(add_multiplied_totalは外から足された基礎移動速度も含めて
# 掛け算するため、自分の修飾子を入れ直すだけでよい。per_stackは内部の100倍値、percentなのでさらに÷100する)

# 新形式の正本があるときは、この1件の件数ではなく正本の合計で入れ直す
# (#buff_stacks はこの呼び出しで選ばれた段の数で、いまの総量ではない)
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff_state{version:2} run return run function test:buff/native/reconcile

scoreboard players operation #speed_up test.buff.work = #buff_stacks test.buff.work
$scoreboard players set #speed_up_per test.buff.work $(per_stack)
scoreboard players operation #speed_up test.buff.work *= #speed_up_per test.buff.work

data modify storage test: buff_work.attr_arg set value {attribute:"minecraft:movement_speed",modifier:"test:speed_up",operation:"add_multiplied_total",amount:0.0d}
execute store result storage test: buff_work.attr_arg.amount double 0.0001 run scoreboard players get #speed_up test.buff.work

function test:buff/attribute/add with storage test: buff_work.attr_arg
