#> test:battle/ui/active_skill_cart_tick
# @s = アクティブスキル選択トロッコ本体(test:tickから毎tick呼ばれる)。取られたスロットを見て、
# battle.temporary.active_skill_slotに控えておいた対応するスキルを発動する
# (スロット番号とスキルの対応はpopulate時にbattle.temporary.active_skill_slotへ積んだ順のまま)

execute if data storage test: battle.temporary.active_skill_slot[0] unless entity @s[nbt={Items:[{Slot:0b}]}] as @p[distance=..3] at @s run function test:battle/ui/active_skill_minecart_resolve {index:0}
execute if data storage test: battle.temporary.active_skill_slot[1] unless entity @s[nbt={Items:[{Slot:1b}]}] as @p[distance=..3] at @s run function test:battle/ui/active_skill_minecart_resolve {index:1}
execute if data storage test: battle.temporary.active_skill_slot[2] unless entity @s[nbt={Items:[{Slot:2b}]}] as @p[distance=..3] at @s run function test:battle/ui/active_skill_minecart_resolve {index:2}
execute if data storage test: battle.temporary.active_skill_slot[3] unless entity @s[nbt={Items:[{Slot:3b}]}] as @p[distance=..3] at @s run function test:battle/ui/active_skill_minecart_resolve {index:3}
execute if data storage test: battle.temporary.active_skill_slot[4] unless entity @s[nbt={Items:[{Slot:4b}]}] as @p[distance=..3] at @s run function test:battle/ui/active_skill_minecart_resolve {index:4}
execute if data storage test: battle.temporary.active_skill_slot[5] unless entity @s[nbt={Items:[{Slot:5b}]}] as @p[distance=..3] at @s run function test:battle/ui/active_skill_minecart_resolve {index:5}
execute if data storage test: battle.temporary.active_skill_slot[6] unless entity @s[nbt={Items:[{Slot:6b}]}] as @p[distance=..3] at @s run function test:battle/ui/active_skill_minecart_resolve {index:6}
execute if data storage test: battle.temporary.active_skill_slot[7] unless entity @s[nbt={Items:[{Slot:7b}]}] as @p[distance=..3] at @s run function test:battle/ui/active_skill_minecart_resolve {index:7}
