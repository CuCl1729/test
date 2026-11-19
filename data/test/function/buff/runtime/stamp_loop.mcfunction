#> test:buff/runtime/stamp_loop
# 内部。#rt_seq から #rt_newseq の手前まで、新しく出た連番だけを1つずつ押していく
execute unless score #rt_seq test.buff.work < #rt_newseq test.buff.work run return 0
execute store result storage test: buff_runtime.work.stamp.seq int 1 run scoreboard players get #rt_seq test.buff.work
function test:buff/runtime/stamp_one with storage test: buff_runtime.work.stamp
scoreboard players add #rt_seq test.buff.work 1
function test:buff/runtime/stamp_loop
