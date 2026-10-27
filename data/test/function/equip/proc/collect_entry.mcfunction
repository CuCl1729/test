#> test:equip/proc/collect_entry
# @macro part/idx: 枠を見分けるキーの部位と枠番号。equip_work.slot(今見ている枠)が、イベントで動くものなら
# 自動発動の一覧(equip_work.procs)に "<部位>_<枠番号>" のキーを付けて足す。
# - 魔法の枠(kind:"magic"。kindが無く魔法がある枠は、kindを足す前に作った装備の魔法の枠)
# - アイテムの枠(kind:"item"。キーは回数のカウント test.equip.proc_count.<キー> に使う)
# - ルーンの枠は常に効く能力なので足さない(test:equip/add_itemが能力として集計する)。空の枠も足さない

scoreboard players set #proc_collect test.temporary 0
execute if data storage test: equip_work.slot{kind:"magic"} run scoreboard players set #proc_collect test.temporary 1
execute unless data storage test: equip_work.slot.kind if data storage test: equip_work.slot.magic run scoreboard players set #proc_collect test.temporary 1
execute if data storage test: equip_work.slot{kind:"item"} run scoreboard players set #proc_collect test.temporary 1
execute if score #proc_collect test.temporary matches 0 run return 0

data modify storage test: equip_work.procs append from storage test: equip_work.slot
$data modify storage test: equip_work.procs[-1].key set value "$(part)_$(idx)"
