#> test:buff/events/project/unit_step
# 内部。pending の先頭ユニットから行を1本だけ抜いて project/row へ渡す。
# #bq_take は「このユニットから抜けたか」の印(抜いた後の rows[0] で見ると状態がずれる)。
# #bq_any は周ぜんたいで1本でも抜けたかの印で、次の周を回すかどうかに使う
# 残り(cur)はそのまま units へ戻す(ユニットの並びと残り行の状態を次の周へ持ち越す)

data remove storage test: buff_project.work.cur
data modify storage test: buff_project.work.cur set from storage test: buff_project.work.pending[0]
data remove storage test: buff_project.work.pending[0]

scoreboard players set #bq_take test.buff.work 0
execute if data storage test: buff_project.work.cur.rows[0] run scoreboard players set #bq_take test.buff.work 1
execute if score #bq_take test.buff.work matches 1 run scoreboard players set #bq_any test.buff.work 1
execute if score #bq_take test.buff.work matches 1 run data modify storage test: buff_project.work.row set from storage test: buff_project.work.cur.rows[0]
execute if score #bq_take test.buff.work matches 1 run data remove storage test: buff_project.work.cur.rows[0]
execute if score #bq_take test.buff.work matches 1 run function test:buff/events/project/row

data modify storage test: buff_project.work.units append from storage test: buff_project.work.cur

execute if data storage test: buff_project.work.pending[0] run function test:buff/events/project/unit_step
