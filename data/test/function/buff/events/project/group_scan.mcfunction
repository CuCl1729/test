#> test:buff/events/project/group_scan
# 内部。scan を groups へ回転させながら、候補の鍵と同じ最初の group へ合流させる。
# 「何も変わらなかった」判定で鍵の等しさを見る(#bq_ne=0 なら等しい)。並びは保つ

data remove storage test: buff_project.work.g
data modify storage test: buff_project.work.g set from storage test: buff_project.work.scan[0]
data remove storage test: buff_project.work.scan[0]

execute if score #bq_hit test.buff.work matches 0 run data modify storage test: buff_project.work.cmp set from storage test: buff_project.work.cand.key
execute if score #bq_hit test.buff.work matches 0 store success score #bq_ne test.buff.work run data modify storage test: buff_project.work.cmp set from storage test: buff_project.work.g.key
execute if score #bq_hit test.buff.work matches 0 if score #bq_ne test.buff.work matches 0 run data modify storage test: buff_project.work.g.job.units append from storage test: buff_project.work.cur.unit
execute if score #bq_hit test.buff.work matches 0 if score #bq_ne test.buff.work matches 0 run scoreboard players set #bq_hit test.buff.work 1

data modify storage test: buff_project.work.groups append from storage test: buff_project.work.g

execute if data storage test: buff_project.work.scan[0] run function test:buff/events/project/group_scan
