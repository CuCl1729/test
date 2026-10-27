#> test:asset/equip/proc_add
# @macro proc_index: 抽選した asset.equip.proc_events の番号。その番号のイベントの枠を1つ足す(魔法はまだ入れない)

data modify storage test: loot.item.components."minecraft:custom_data".equip.procs append value {}
$data modify storage test: loot.item.components."minecraft:custom_data".equip.procs[-1].event set from storage test: asset.equip.proc_events[$(proc_index)].id
