#> test:equip/proc/run
# @s = 自動発動の予約があるプレイヤー(test:tickから、at @s)。
# 着ている防具の自動発動の魔法(test.equip.procs)のうち、予約されたイベントのものを唱え、予約を消す。
# ダウン中・倒れているときは唱えずに予約だけ消す

execute unless entity @s[tag=downed] if score @s test.status.hp matches 1.. run function test:equip/proc/run_all

tag @s remove equip_proc_queued
tag @s remove equip_proc.magic_cast
tag @s remove equip_proc.attack_hit
tag @s remove equip_proc.damaged
tag @s remove equip_proc.hp_low
