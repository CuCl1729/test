#> test:equip/proc/run_entry
# @macro event: 自動発動の1件のイベント(他のキーも渡ってくるが、中身はproc_queue[0]から読む)。
# そのイベントが予約されていれば、枠の中身の種類ごとに振り分ける
# - 魔法(kind:"magic"、またはkindが無く魔法がある枠): test:equip/proc/cast

$execute unless entity @s[tag=equip_proc.$(event)] run return 0

data modify storage test: equip_work.proc_cur set from storage test: equip_work.proc_queue[0]

execute unless data storage test: equip_work.proc_cur.magic run return 0
$function test:debug/log {msg:"防具の自動発動(魔法): $(event)"}
function test:equip/proc/cast
