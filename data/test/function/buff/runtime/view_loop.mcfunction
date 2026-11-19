#> test:buff/runtime/view_loop
# 内部。正本の段のまとまりを1件ずつ消費して、表示用の写し
# {id,stacks:<段数>,remaining:<段のうち最大の残り>,elapsed:<最も古い段の経過>} を組む
execute unless data storage test: buff_runtime.work.groups[0] run return 0

scoreboard players set #rt_rem test.buff.work 0
execute store result score #rt_rem test.buff.work run data get storage test: buff_runtime.work.groups[0].units[0].remaining
data modify storage test: buff_runtime.work.units set from storage test: buff_runtime.work.groups[0].units
function test:buff/runtime/view_unit_loop

data modify storage test: buff_runtime.work.row set value {stacks:0,remaining:0,elapsed:0}
data modify storage test: buff_runtime.work.row.id set from storage test: buff_runtime.work.groups[0].id
execute store result storage test: buff_runtime.work.row.stacks int 1 run data get storage test: buff_runtime.work.groups[0].units
execute store result storage test: buff_runtime.work.row.remaining int 1 run scoreboard players get #rt_rem test.buff.work
data modify storage test: buff_runtime.work.row.elapsed set from storage test: buff_runtime.work.groups[0].units[0].elapsed
data modify storage test: buff_runtime.work.view append from storage test: buff_runtime.work.row

data remove storage test: buff_runtime.work.groups[0]
function test:buff/runtime/view_loop
