#> test:equip/proc/watch_check
# @s = しきい値型のイベントの枠を持つプレイヤー(test.equip.has_watch=1。test:tickから、at @s)。
# HPなどはダメージ以外(毒など)でも減るので、ダメージ処理の中ではなくtickで毎回比べる

data modify storage test: equip_work.watch_queue set from storage test: asset.equip.proc_events
function test:equip/proc/watch_check_loop
