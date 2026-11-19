#> test:buff/events/project/event
# 内部。先頭のイベントを1件取り出して仕事へ写し、events が尽きるまで自分を呼び直す。
# groups/units は1イベントごとの作業台なので、取り出した直後に空へ戻す

data remove storage test: buff_project.work.ev
data modify storage test: buff_project.work.ev set from storage test: buff_project.work.events[0]
data remove storage test: buff_project.work.events[0]

data modify storage test: buff_project.work.groups set value []
data modify storage test: buff_project.work.units set value []

data modify storage test: buff_project.work.q set value []
execute if data storage test: buff_project.work.ev.units run data modify storage test: buff_project.work.q set from storage test: buff_project.work.ev.units
execute if data storage test: buff_project.work.q[0] run function test:buff/events/project/unit_prep

execute if data storage test: buff_project.work.units[0] run function test:buff/events/project/row_pass

execute if data storage test: buff_project.work.groups[0] run function test:buff/events/project/emit

execute if data storage test: buff_project.work.events[0] run function test:buff/events/project/event
