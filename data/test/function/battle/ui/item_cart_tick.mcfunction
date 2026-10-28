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
