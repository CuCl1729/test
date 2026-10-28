#> test:equip/proc/untag_loop
# @s = プレイヤー。equip_work.untag_queue(イベントの一覧のコピー)を先頭から見て、予約のタグ equip_proc.<id> を外す
# (イベントを増やしても test:equip/proc/run を直さなくて済むように、一覧から外す)

execute unless data storage test: equip_work.untag_queue[0] run return 0

function test:equip/proc/untag_entry with storage test: equip_work.untag_queue[0]

data remove storage test: equip_work.untag_queue[0]
function test:equip/proc/untag_loop
