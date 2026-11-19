#> test:buff/events/frame_restore
# 内部。積みの一番上の入り口の状態を戻す(積みは外さない。外すのは呼び出した側)。
# 実体の状態(得点・正本・タグ)は戻さない。入れ子が変えたものを取り消してはいけない

data remove storage test: buff_work
data modify storage test: buff_work set from storage test: buff_frames.stack[0].work
data remove storage test: buff_context
data modify storage test: buff_context set from storage test: buff_frames.stack[0].context
data remove storage test: buff_runtime.arg
data modify storage test: buff_runtime.arg set from storage test: buff_frames.stack[0].arg
data remove storage test: buff_runtime.result
data modify storage test: buff_runtime.result set from storage test: buff_frames.stack[0].result
data remove storage test: buff_event
data modify storage test: buff_event set from storage test: buff_frames.stack[0].event

# 添字つきの道に {…} は書けないので、印は一旦この得点に読む(途中で呼び出しは起きない)
execute store result score #bq_has_stacks test.buff.work run data get storage test: buff_frames.stack[0].has_stacks
scoreboard players reset #buff_stacks test.buff.work
execute if score #bq_has_stacks test.buff.work matches 1 store result score #buff_stacks test.buff.work run data get storage test: buff_frames.stack[0].stacks
execute store result score #bq_has_at test.buff.work run data get storage test: buff_frames.stack[0].has_at
scoreboard players reset #buff_at test.buff.work
execute if score #bq_has_at test.buff.work matches 1 store result score #buff_at test.buff.work run data get storage test: buff_frames.stack[0].at

execute if data storage test: buff_frames.stack[0].dat run function test:buff/events/frame_dat
