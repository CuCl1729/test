#> test:equip/add_item
# @s = プレイヤー。storage test: equip_work.item(装備1つぶんのcustom_data)のステータスを集計値に足す。
# 防具・アクセサリーはbase_statusを持たない方針だが、持っていても足せるようにしておく

execute if data storage test: equip_work.item.status_bonus run data modify storage test: equip_work.entry set from storage test: equip_work.item.status_bonus
execute if data storage test: equip_work.item.status_bonus run function test:equip/add_entry with storage test: equip_work.entry
execute if data storage test: equip_work.item.base_status run data modify storage test: equip_work.entry set from storage test: equip_work.item.base_status
execute if data storage test: equip_work.item.base_status run function test:equip/add_entry with storage test: equip_work.entry

data modify storage test: equip_work.entry_queue set value []
data modify storage test: equip_work.entry_queue set from storage test: equip_work.item.substatus
function test:equip/entry_loop

# 自動発動の枠のうち、イベントで動くもの(魔法)を、枠を見分けるキー付きで一覧に足す
# (test:equip/recalcが個別ストレージへ写す)。キーの部位は呼び出し元が equip_work.part に入れてある
data modify storage test: equip_work.slot_queue set value []
data modify storage test: equip_work.slot_queue set from storage test: equip_work.item.equip.procs
scoreboard players set #proc_idx test.temporary 0
function test:equip/proc/collect_loop
