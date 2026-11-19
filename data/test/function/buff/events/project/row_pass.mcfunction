#> test:buff/events/project/row_pass
# 内部。全ユニットの「次の1行」だけを横並びで取る1周。
# 行の番号が外側の並び、ユニットの並びが内側の並びになる(行優先の順序を作るため)

scoreboard players set #bq_any test.buff.work 0

data modify storage test: buff_project.work.pending set from storage test: buff_project.work.units
data remove storage test: buff_project.work.units
data modify storage test: buff_project.work.units set value []

execute if data storage test: buff_project.work.pending[0] run function test:buff/events/project/unit_step

execute if score #bq_any test.buff.work matches 1 run function test:buff/events/project/row_pass
