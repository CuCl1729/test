#> test:battle/ui/item_cart_tick
# @s = アイテムのトロッコ本体(test:tickから毎tick、at @s)。取られたスロットの消耗品を、取ったプレイヤーが使う
# (スロット番号は battle.temporary.item_slot の位置。test:battle/ui/item_hover_summon が並べた順)

execute if data storage test: battle.temporary.item_slot[0] unless entity @s[nbt={Items:[{Slot:0b}]}] as @p[distance=..3] at @s run return run function test:battle/ui/item_pick {index:0}
execute if data storage test: battle.temporary.item_slot[1] unless entity @s[nbt={Items:[{Slot:1b}]}] as @p[distance=..3] at @s run return run function test:battle/ui/item_pick {index:1}
execute if data storage test: battle.temporary.item_slot[2] unless entity @s[nbt={Items:[{Slot:2b}]}] as @p[distance=..3] at @s run return run function test:battle/ui/item_pick {index:2}
execute if data storage test: battle.temporary.item_slot[3] unless entity @s[nbt={Items:[{Slot:3b}]}] as @p[distance=..3] at @s run return run function test:battle/ui/item_pick {index:3}
execute if data storage test: battle.temporary.item_slot[4] unless entity @s[nbt={Items:[{Slot:4b}]}] as @p[distance=..3] at @s run return run function test:battle/ui/item_pick {index:4}
execute if data storage test: battle.temporary.item_slot[5] unless entity @s[nbt={Items:[{Slot:5b}]}] as @p[distance=..3] at @s run return run function test:battle/ui/item_pick {index:5}
execute if data storage test: battle.temporary.item_slot[6] unless entity @s[nbt={Items:[{Slot:6b}]}] as @p[distance=..3] at @s run return run function test:battle/ui/item_pick {index:6}
execute if data storage test: battle.temporary.item_slot[7] unless entity @s[nbt={Items:[{Slot:7b}]}] as @p[distance=..3] at @s run return run function test:battle/ui/item_pick {index:7}
execute if data storage test: battle.temporary.item_slot[8] unless entity @s[nbt={Items:[{Slot:8b}]}] as @p[distance=..3] at @s run return run function test:battle/ui/item_pick {index:8}
execute if data storage test: battle.temporary.item_slot[9] unless entity @s[nbt={Items:[{Slot:9b}]}] as @p[distance=..3] at @s run return run function test:battle/ui/item_pick {index:9}
execute if data storage test: battle.temporary.item_slot[10] unless entity @s[nbt={Items:[{Slot:10b}]}] as @p[distance=..3] at @s run return run function test:battle/ui/item_pick {index:10}
execute if data storage test: battle.temporary.item_slot[11] unless entity @s[nbt={Items:[{Slot:11b}]}] as @p[distance=..3] at @s run return run function test:battle/ui/item_pick {index:11}
execute if data storage test: battle.temporary.item_slot[12] unless entity @s[nbt={Items:[{Slot:12b}]}] as @p[distance=..3] at @s run return run function test:battle/ui/item_pick {index:12}
execute if data storage test: battle.temporary.item_slot[13] unless entity @s[nbt={Items:[{Slot:13b}]}] as @p[distance=..3] at @s run return run function test:battle/ui/item_pick {index:13}
execute if data storage test: battle.temporary.item_slot[14] unless entity @s[nbt={Items:[{Slot:14b}]}] as @p[distance=..3] at @s run return run function test:battle/ui/item_pick {index:14}
execute if data storage test: battle.temporary.item_slot[15] unless entity @s[nbt={Items:[{Slot:15b}]}] as @p[distance=..3] at @s run return run function test:battle/ui/item_pick {index:15}
execute if data storage test: battle.temporary.item_slot[16] unless entity @s[nbt={Items:[{Slot:16b}]}] as @p[distance=..3] at @s run return run function test:battle/ui/item_pick {index:16}
execute if data storage test: battle.temporary.item_slot[17] unless entity @s[nbt={Items:[{Slot:17b}]}] as @p[distance=..3] at @s run return run function test:battle/ui/item_pick {index:17}
execute if data storage test: battle.temporary.item_slot[18] unless entity @s[nbt={Items:[{Slot:18b}]}] as @p[distance=..3] at @s run return run function test:battle/ui/item_pick {index:18}
execute if data storage test: battle.temporary.item_slot[19] unless entity @s[nbt={Items:[{Slot:19b}]}] as @p[distance=..3] at @s run return run function test:battle/ui/item_pick {index:19}
execute if data storage test: battle.temporary.item_slot[20] unless entity @s[nbt={Items:[{Slot:20b}]}] as @p[distance=..3] at @s run return run function test:battle/ui/item_pick {index:20}
execute if data storage test: battle.temporary.item_slot[21] unless entity @s[nbt={Items:[{Slot:21b}]}] as @p[distance=..3] at @s run return run function test:battle/ui/item_pick {index:21}
execute if data storage test: battle.temporary.item_slot[22] unless entity @s[nbt={Items:[{Slot:22b}]}] as @p[distance=..3] at @s run return run function test:battle/ui/item_pick {index:22}
execute if data storage test: battle.temporary.item_slot[23] unless entity @s[nbt={Items:[{Slot:23b}]}] as @p[distance=..3] at @s run return run function test:battle/ui/item_pick {index:23}
execute if data storage test: battle.temporary.item_slot[24] unless entity @s[nbt={Items:[{Slot:24b}]}] as @p[distance=..3] at @s run return run function test:battle/ui/item_pick {index:24}
execute if data storage test: battle.temporary.item_slot[25] unless entity @s[nbt={Items:[{Slot:25b}]}] as @p[distance=..3] at @s run return run function test:battle/ui/item_pick {index:25}
