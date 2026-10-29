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
execute if data storage test: battle.temporary.active_skill_slot[8] unless entity @s[nbt={Items:[{Slot:8b}]}] as @p[distance=..3] at @s run function test:battle/ui/active_skill_minecart_resolve {index:8}
execute if data storage test: battle.temporary.active_skill_slot[9] unless entity @s[nbt={Items:[{Slot:9b}]}] as @p[distance=..3] at @s run function test:battle/ui/active_skill_minecart_resolve {index:9}
execute if data storage test: battle.temporary.active_skill_slot[10] unless entity @s[nbt={Items:[{Slot:10b}]}] as @p[distance=..3] at @s run function test:battle/ui/active_skill_minecart_resolve {index:10}
execute if data storage test: battle.temporary.active_skill_slot[11] unless entity @s[nbt={Items:[{Slot:11b}]}] as @p[distance=..3] at @s run function test:battle/ui/active_skill_minecart_resolve {index:11}
execute if data storage test: battle.temporary.active_skill_slot[12] unless entity @s[nbt={Items:[{Slot:12b}]}] as @p[distance=..3] at @s run function test:battle/ui/active_skill_minecart_resolve {index:12}
execute if data storage test: battle.temporary.active_skill_slot[13] unless entity @s[nbt={Items:[{Slot:13b}]}] as @p[distance=..3] at @s run function test:battle/ui/active_skill_minecart_resolve {index:13}
execute if data storage test: battle.temporary.active_skill_slot[14] unless entity @s[nbt={Items:[{Slot:14b}]}] as @p[distance=..3] at @s run function test:battle/ui/active_skill_minecart_resolve {index:14}
execute if data storage test: battle.temporary.active_skill_slot[15] unless entity @s[nbt={Items:[{Slot:15b}]}] as @p[distance=..3] at @s run function test:battle/ui/active_skill_minecart_resolve {index:15}
execute if data storage test: battle.temporary.active_skill_slot[16] unless entity @s[nbt={Items:[{Slot:16b}]}] as @p[distance=..3] at @s run function test:battle/ui/active_skill_minecart_resolve {index:16}
execute if data storage test: battle.temporary.active_skill_slot[17] unless entity @s[nbt={Items:[{Slot:17b}]}] as @p[distance=..3] at @s run function test:battle/ui/active_skill_minecart_resolve {index:17}
execute if data storage test: battle.temporary.active_skill_slot[18] unless entity @s[nbt={Items:[{Slot:18b}]}] as @p[distance=..3] at @s run function test:battle/ui/active_skill_minecart_resolve {index:18}
execute if data storage test: battle.temporary.active_skill_slot[19] unless entity @s[nbt={Items:[{Slot:19b}]}] as @p[distance=..3] at @s run function test:battle/ui/active_skill_minecart_resolve {index:19}
execute if data storage test: battle.temporary.active_skill_slot[20] unless entity @s[nbt={Items:[{Slot:20b}]}] as @p[distance=..3] at @s run function test:battle/ui/active_skill_minecart_resolve {index:20}
execute if data storage test: battle.temporary.active_skill_slot[21] unless entity @s[nbt={Items:[{Slot:21b}]}] as @p[distance=..3] at @s run function test:battle/ui/active_skill_minecart_resolve {index:21}
execute if data storage test: battle.temporary.active_skill_slot[22] unless entity @s[nbt={Items:[{Slot:22b}]}] as @p[distance=..3] at @s run function test:battle/ui/active_skill_minecart_resolve {index:22}
execute if data storage test: battle.temporary.active_skill_slot[23] unless entity @s[nbt={Items:[{Slot:23b}]}] as @p[distance=..3] at @s run function test:battle/ui/active_skill_minecart_resolve {index:23}
execute if data storage test: battle.temporary.active_skill_slot[24] unless entity @s[nbt={Items:[{Slot:24b}]}] as @p[distance=..3] at @s run function test:battle/ui/active_skill_minecart_resolve {index:24}
execute if data storage test: battle.temporary.active_skill_slot[25] unless entity @s[nbt={Items:[{Slot:25b}]}] as @p[distance=..3] at @s run function test:battle/ui/active_skill_minecart_resolve {index:25}
