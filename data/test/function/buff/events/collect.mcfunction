#> test:buff/events/collect
# 内部。自分の枠の結果のイベントを仕事へ写し、待ち行列の末尾へ足す。
# 投影は純粋(buff_project の作業域しか触らない)、待ち行列を触るのは enqueue だけ

data modify storage test: buff_project.arg set value {events:[]}
data modify storage test: buff_project.arg.events set from storage test: buff_frames.stack[0].myresult.events
function test:buff/events/project
function test:buff/events/enqueue
