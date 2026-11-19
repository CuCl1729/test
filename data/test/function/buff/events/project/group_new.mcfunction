#> test:buff/events/project/group_new
# 内部。row で合流先が見つからなかった候補から、新しい group を作って並びの末尾へ足す

data modify storage test: buff_project.work.new set value {}
data modify storage test: buff_project.work.new.key set from storage test: buff_project.work.cand.key
data modify storage test: buff_project.work.new.job set value {units:[]}
data modify storage test: buff_project.work.new.job.target set from storage test: buff_project.work.ev.target
# 的の身元は仕事へそのまま運ぶ(まとめる鍵には入れない。元のイベントごとのまとまりは変えない)
execute if data storage test: buff_project.work.ev.target_uuid run data modify storage test: buff_project.work.new.job.target_uuid set from storage test: buff_project.work.ev.target_uuid
data modify storage test: buff_project.work.new.job.id set from storage test: buff_project.work.ev.id
data modify storage test: buff_project.work.new.job.event set from storage test: buff_project.work.ev.event
data modify storage test: buff_project.work.new.job.reason set from storage test: buff_project.work.ev.reason
data modify storage test: buff_project.work.new.job.n set from storage test: buff_project.work.ev.n
data modify storage test: buff_project.work.new.job.row set from storage test: buff_project.work.cand.key.row
data modify storage test: buff_project.work.new.job.params set from storage test: buff_project.work.cand.key.params
data modify storage test: buff_project.work.new.job.units append from storage test: buff_project.work.cur.unit

data modify storage test: buff_project.work.groups append from storage test: buff_project.work.new
