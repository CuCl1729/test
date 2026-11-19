#> test:buff/notify_loop
# 内部。@s = 受け手。buff_work.notes(この取引の台帳イベント)を先頭から1件ずつ通知する
execute unless data storage test: buff_work.notes[0] run return 0
data modify storage test: buff_work.note set from storage test: buff_work.notes[0]
data remove storage test: buff_work.notes[0]
function test:buff/notify_one with storage test: buff_work.note
function test:buff/notify_loop
