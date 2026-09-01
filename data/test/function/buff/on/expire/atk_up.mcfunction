#> test:buff/on/expire/atk_up
# @s = バフ保持者。#buff_stacks test.buff.work には「終了する時点の」スタック数が入っている
# applyで足したぶんをそのまま戻す

scoreboard players operation #atk_up test.buff.work = #buff_stacks test.buff.work
scoreboard players operation #atk_up test.buff.work *= #500 test.constant

data modify storage test: buff_work.stat_arg set value {stat:"atk",amount:0}
execute store result storage test: buff_work.stat_arg.amount int 1 run scoreboard players get #atk_up test.buff.work

function test:buff/stat/remove with storage test: buff_work.stat_arg
