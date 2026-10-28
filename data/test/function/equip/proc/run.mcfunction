#> test:equip/proc/run
# @s = 自動発動の予約があるプレイヤー(test:tickから、at @s)。
# 着ている防具の自動発動の魔法(test.equip.procs)のうち、予約されたイベントのものを唱え、予約を消す。
# ダウン中・倒れているときは唱えずに予約だけ消す

execute unless entity @s[tag=downed] if score @s test.status.hp matches 1.. run function test:equip/proc/run_all

tag @s remove equip_proc_queued
# 各イベントの予約タグ equip_proc.<id> は、イベントの一覧(asset.equip.proc_events)から外す
data modify storage test: equip_work.untag_queue set from storage test: asset.equip.proc_events
function test:equip/proc/untag_loop
