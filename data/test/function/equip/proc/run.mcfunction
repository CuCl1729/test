#> test:equip/proc/run
# @s = 自動発動の予約があるプレイヤー(at @s)。リアルタイムでは test:tick から、ターン制の戦闘中は手番の終わりに
# test:battle/proc_all から呼ばれる。着ている防具の自動発動の枠のうち、予約されたイベントのものを実行し、予約を消す。
# ダウン中・倒れているときは実行せずに予約だけ消す

execute unless entity @s[tag=downed] if score @s test.status.hp matches 1.. run function test:equip/proc/run_all

function test:equip/proc/clear_queue
