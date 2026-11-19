#> test:buff/events/project/row
# 内部。1行を groups へ振り分ける。配る種の行で、event がイベントと一致するものだけを拾う。
# 同じ鍵(row+params)の候補は既存の group に合流させ、無ければ新しい group を作る

# 拾う種は function と資源の種(heal / damage。damage は防御無視の true も属性付きも)
scoreboard players set #bq_res test.buff.work 0
execute if data storage test: buff_project.work.row{kind:"heal"} run scoreboard players set #bq_res test.buff.work 1
execute if data storage test: buff_project.work.row{kind:"damage"} run scoreboard players set #bq_res test.buff.work 1
execute if score #bq_res test.buff.work matches 0 unless data storage test: buff_project.work.row{kind:"function"} run return 0
execute unless data storage test: buff_project.work.row.event run return 0

data modify storage test: buff_project.work.cmp set from storage test: buff_project.work.ev.event
execute store success score #bq_ne test.buff.work run data modify storage test: buff_project.work.cmp set from storage test: buff_project.work.row.event
execute if score #bq_ne test.buff.work matches 1 run return 0

data modify storage test: buff_project.work.cand set value {key:{}}
data modify storage test: buff_project.work.cand.key.row set from storage test: buff_project.work.row
data modify storage test: buff_project.work.cand.key.params set value {}
# params はマクロの入力なので function の鍵には要る。資源の種は value と術者の参照の
# ほかに実行の入力を持たないので、params は鍵から外す(#bq_res=0 は function だけ)
execute if score #bq_res test.buff.work matches 0 run data modify storage test: buff_project.work.cand.key.params set from storage test: buff_project.work.cur.unit.eff.params
# 評価した value は術者ごとに違うので、資源の種ではまとめる鍵から外す。
# そうしないと同じ行が術者ごとに別の仕事へ割れてしまう(function の鍵は今までどおり)
execute if score #bq_res test.buff.work matches 1 run data remove storage test: buff_project.work.cand.key.row.value

scoreboard players set #bq_hit test.buff.work 0
data modify storage test: buff_project.work.scan set from storage test: buff_project.work.groups
data remove storage test: buff_project.work.groups
data modify storage test: buff_project.work.groups set value []
execute if data storage test: buff_project.work.scan[0] run function test:buff/events/project/group_scan

execute if score #bq_hit test.buff.work matches 0 run function test:buff/events/project/group_new
