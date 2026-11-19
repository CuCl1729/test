#> test:buff/runtime/view_unit_loop
# 内部。今のまとまりの段を1つずつ見て、残りの最大を #rt_rem に取る
execute unless data storage test: buff_runtime.work.units[0] run return 0
execute store result score #rt_v test.buff.work run data get storage test: buff_runtime.work.units[0].remaining
execute if score #rt_v test.buff.work > #rt_rem test.buff.work run scoreboard players operation #rt_rem test.buff.work = #rt_v test.buff.work
data remove storage test: buff_runtime.work.units[0]
function test:buff/runtime/view_unit_loop
