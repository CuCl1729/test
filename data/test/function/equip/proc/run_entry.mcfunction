#> test:equip/proc/run_entry
# @macro event: 自動発動の1件のイベント(magic・nameも渡ってくるが使わない。唱えるのはcastがproc_queue[0]から読む)。
# そのイベントが予約されていれば唱える

$execute unless entity @s[tag=equip_proc.$(event)] run return 0

$function test:debug/log {msg:"防具の自動発動: $(event)"}
function test:equip/proc/cast
