#> test:buff/on/apply/atk_up
# @s = バフ保持者。#buff_stacks test.buff.work に付与後のスタック数が入っている
# 1スタックにつき攻撃力+5(内部は100倍値なので500)。expire側で同じ量を戻す
# (掛け直しのときは古いスタック数でexpireが先に出るため、数がずれることはない)

scoreboard players operation #atk_up test.buff.work = #buff_stacks test.buff.work
scoreboard players operation #atk_up test.buff.work *= #500 test.constant

data modify storage test: buff_work.stat_arg set value {stat:"atk",amount:0}
execute store result storage test: buff_work.stat_arg.amount int 1 run scoreboard players get #atk_up test.buff.work

function test:buff/stat/add with storage test: buff_work.stat_arg
