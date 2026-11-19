#> test:buff/events/project/unit_prep
# 内部。q の先頭ユニットを units[].{unit,rows} へ積み替える。
# rows は eff.effects の写し(無ければ持たない)。行の並びはそのまま保つ

data remove storage test: buff_project.work.u
data modify storage test: buff_project.work.u set from storage test: buff_project.work.q[0]
data remove storage test: buff_project.work.q[0]

data modify storage test: buff_project.work.cell set value {}
data modify storage test: buff_project.work.cell.unit set from storage test: buff_project.work.u
data modify storage test: buff_project.work.cell.rows set value []
execute if data storage test: buff_project.work.u.eff.effects[0] run data modify storage test: buff_project.work.cell.rows set from storage test: buff_project.work.u.eff.effects

data modify storage test: buff_project.work.units append from storage test: buff_project.work.cell

execute if data storage test: buff_project.work.q[0] run function test:buff/events/project/unit_prep
