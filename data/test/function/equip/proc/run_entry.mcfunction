#> test:equip/proc/run_entry
# @macro event: 自動発動の1件のイベント(他のキーも渡ってくるが、中身はproc_queue[0]から読む)。
# そのイベントが予約されていれば、枠の中身の種類ごとに振り分ける
# - アイテム(kind:"item"): test:equip/proc/use_item(MPは使わない。イベント every 回ごとに1個使う)
# - 魔法(kind:"magic"、またはkindが無く魔法がある枠): test:equip/proc/cast
#   (ターン制の戦闘中は test:equip/proc/cast_battle。対象を自動で選び、ターン制の魔法と同じ処理で唱える)

$execute unless entity @s[tag=equip_proc.$(event)] run return 0

data modify storage test: equip_work.proc_cur set from storage test: equip_work.proc_queue[0]

execute if data storage test: equip_work.proc_cur{kind:"item"} run return run function test:equip/proc/use_item with storage test: equip_work.proc_cur

execute unless data storage test: equip_work.proc_cur.magic run return 0
$function test:debug/log {msg:"防具の自動発動(魔法): $(event)"}
execute if score @s test.battle.id matches 1.. run return run function test:equip/proc/cast_battle
function test:equip/proc/cast
