#> test:buff/events/submit
# @s = 効果を受ける側(recipient。OhMyDatID を持つこと)。
# storage test: buff_runtime.arg は test:buff/runtime/operate と同じ(ここでは読むだけ)。
#
#   1回ぶんの取引をそのまま走らせ、成功したイベントのうち関数行ぶんを仕事へ写し、
#   待ち行列の末尾へ足す。まとめ(begin/end)の中でも配っている途中でもなければ、そこで配る。
#   戻り値は operate と同じ 1/0。失敗した取引は仕事をひとつも作らない。
#   呼び出し元から見える buff_runtime.result は「この呼び出しの」結果で、
#   利用者の関数の中で起きた入れ子の結果ではない

function test:buff/events/frame_push
execute store result score #bq_ok test.buff.work run function test:buff/runtime/operate

# 自分の結果と戻り値は自分の枠に置く(入れ子は別の枠を使うので混ざらない)
data modify storage test: buff_frames.stack[0].ok set value 0
execute store result storage test: buff_frames.stack[0].ok int 1 run scoreboard players get #bq_ok test.buff.work
data modify storage test: buff_frames.stack[0].myresult set from storage test: buff_runtime.result

# ネイティブの修飾子は、配る前に正本の合計へ合わせる。イベントが1件も無い維持でも合わせる
# (個別のコールバックや関数タグが、途中の間違った量を見てしまわないため)
execute if score #bq_ok test.buff.work matches 1 run function test:buff/native/reconcile

execute if score #bq_ok test.buff.work matches 1 run function test:buff/events/collect

# 入り口の状態を戻してから配る。利用者の関数は呼び出し元の文脈を見てはいけない
function test:buff/events/frame_restore
execute unless score #bq_hold test.buff.work matches 1.. unless score #bq_draining test.buff.work matches 1 run function test:buff/events/drain

# 配り終わってから、この呼び出しの結果を見せる
data remove storage test: buff_runtime.result
data modify storage test: buff_runtime.result set from storage test: buff_frames.stack[0].myresult
execute store result score #bq_ret test.buff.work run data get storage test: buff_frames.stack[0].ok
data remove storage test: buff_frames.stack[0]
return run scoreboard players get #bq_ret test.buff.work
