#> test:equip/proc/watch_recalc
# @s = プレイヤー(test:equip/recalc の中。equip_work.procs は集計済み)。
# しきい値型のイベント(asset.equip.proc_events の below を持つもの)ごとに、その枠に中身があればタグ equip_watch.<id> を付ける。
# 1つでもあれば test.equip.has_watch を1にし、tickで見張る(test:equip/proc/watch_check)

# 共通化する前の hp_low 専用のタグ(残っていると邪魔になるので外しておく)
tag @s remove equip_hp_low

scoreboard players set @s test.equip.has_watch 0
data modify storage test: equip_work.watch_queue set from storage test: asset.equip.proc_events
function test:equip/proc/watch_recalc_loop
