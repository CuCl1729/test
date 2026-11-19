#> test:buff/events/frame_push
# 内部。1件ぶんの入り口の状態を、入れ子でも混ざらない積み(buff_frames.stack[0]が一番上)へ退避する。
# 鍵を作らないことで「無かったもの」は無かったまま戻せる(得点だけは別に印を持つ)

execute unless data storage test: buff_frames.stack run data modify storage test: buff_frames.stack set value []
data modify storage test: buff_frames.stack prepend value {}

data modify storage test: buff_frames.stack[0].work set from storage test: buff_work
data modify storage test: buff_frames.stack[0].context set from storage test: buff_context
data modify storage test: buff_frames.stack[0].arg set from storage test: buff_runtime.arg
data modify storage test: buff_frames.stack[0].result set from storage test: buff_runtime.result
data modify storage test: buff_frames.stack[0].event set from storage test: buff_event

# 得点は「無い」を鍵の不在で表せないので、取れたかどうかを印にする
# 添字つきの道に {…} は書けないので、取れたかどうかは一旦この得点で持つ(途中で呼び出しは起きない)
execute store success score #bq_has_stacks test.buff.work store success storage test: buff_frames.stack[0].has_stacks byte 1 run scoreboard players get #buff_stacks test.buff.work
execute if score #bq_has_stacks test.buff.work matches 1 store result storage test: buff_frames.stack[0].stacks int 1 run scoreboard players get #buff_stacks test.buff.work
execute store success score #bq_has_at test.buff.work store success storage test: buff_frames.stack[0].has_at byte 1 run scoreboard players get #buff_at test.buff.work
execute if score #bq_has_at test.buff.work matches 1 store result storage test: buff_frames.stack[0].at int 1 run scoreboard players get #buff_at test.buff.work

# OhMyDat の居場所は、これから動かす前の値を覚える
data modify storage test: buff_frames.stack[0].dat set from storage oh_my_dat: last_id
