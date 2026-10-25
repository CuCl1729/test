#> test:equip/set_check
# @s = プレイヤー。@macro id: シリーズid(宣言はstorage test: equip_work.setに入っている)。
# 着ている部位数を数え、2部位以上ならbonus2のステータスを足し、4部位ならbonus4の特殊効果を一覧に積む

$execute store result score #equip_set_count test.temporary if data storage test: equip_work.sets[{id:"$(id)"}]

execute if score #equip_set_count test.temporary matches 2.. run data modify storage test: equip_work.entry_queue set value []
execute if score #equip_set_count test.temporary matches 2.. run data modify storage test: equip_work.entry_queue set from storage test: equip_work.set.bonus2
execute if score #equip_set_count test.temporary matches 2.. run function test:equip/entry_loop

execute if score #equip_set_count test.temporary matches 4.. run data modify storage test: equip_work.effects append from storage test: equip_work.set.bonus4[]
