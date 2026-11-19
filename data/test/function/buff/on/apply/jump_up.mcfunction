#> test:buff/on/apply/jump_up
# @s = バフ保持者。#buff_stacks test.buff.work に付与後のスタック数が入っている
# 1スタックにつきジャンプ強度+per_stack(表示の単位がそのままadd_valueの量。per_stackは内部の100倍値なので÷100する)

# 新形式の正本があるときは、この1件の件数ではなく正本の合計で入れ直す
# (#buff_stacks はこの呼び出しで選ばれた段の数で、いまの総量ではない)
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.buff_state{version:2} run return run function test:buff/native/reconcile

scoreboard players operation #jump_up test.buff.work = #buff_stacks test.buff.work
$scoreboard players set #jump_up_per test.buff.work $(per_stack)
scoreboard players operation #jump_up test.buff.work *= #jump_up_per test.buff.work

data modify storage test: buff_work.attr_arg set value {attribute:"minecraft:jump_strength",modifier:"test:jump_up",operation:"add_value",amount:0.0d}
execute store result storage test: buff_work.attr_arg.amount double 0.01 run scoreboard players get #jump_up test.buff.work

function test:buff/attribute/add with storage test: buff_work.attr_arg
