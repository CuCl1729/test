#> test:equip/proc/clear_queue
# @s = プレイヤー。自動発動の予約(equip_proc_queued と、各イベントの equip_proc.<id>)をすべて消す。
# 実行した後(test:equip/proc/run)と、戦闘から戻ったとき(残った予約をフィールドで実行しないため)に使う

tag @s remove equip_proc_queued
# 各イベントの予約タグ equip_proc.<id> は、イベントの一覧(asset.equip.proc_events)から外す
data modify storage test: equip_work.untag_queue set from storage test: asset.equip.proc_events
function test:equip/proc/untag_loop
