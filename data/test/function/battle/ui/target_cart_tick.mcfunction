#> test:battle/ui/target_cart_tick
# @s = 対象選択トロッコ本体(test:tickから毎tick呼ばれる)。自分のスロットが取られたか確認する
# (実際に対象が割り当てられているスロットのみ判定する。空きスロットは無視)

execute if data entity @n[tag=battle_marker,distance=..64] data.turn.menus.target[{Slot:0b}] unless entity @s[nbt={Items:[{Slot:0b}]}] run return run function test:battle/ui/cart_pick {screen:"target",slot:0,action:"target_minecart_toggle"}
execute if data entity @n[tag=battle_marker,distance=..64] data.turn.menus.target[{Slot:1b}] unless entity @s[nbt={Items:[{Slot:1b}]}] run return run function test:battle/ui/cart_pick {screen:"target",slot:1,action:"target_minecart_toggle"}
execute if data entity @n[tag=battle_marker,distance=..64] data.turn.menus.target[{Slot:2b}] unless entity @s[nbt={Items:[{Slot:2b}]}] run return run function test:battle/ui/cart_pick {screen:"target",slot:2,action:"target_minecart_toggle"}
execute if data entity @n[tag=battle_marker,distance=..64] data.turn.menus.target[{Slot:3b}] unless entity @s[nbt={Items:[{Slot:3b}]}] run return run function test:battle/ui/cart_pick {screen:"target",slot:3,action:"target_minecart_toggle"}
execute if data entity @n[tag=battle_marker,distance=..64] data.turn.menus.target[{Slot:4b}] unless entity @s[nbt={Items:[{Slot:4b}]}] run return run function test:battle/ui/cart_pick {screen:"target",slot:4,action:"target_minecart_toggle"}
execute if data entity @n[tag=battle_marker,distance=..64] data.turn.menus.target[{Slot:5b}] unless entity @s[nbt={Items:[{Slot:5b}]}] run return run function test:battle/ui/cart_pick {screen:"target",slot:5,action:"target_minecart_toggle"}
execute if data entity @n[tag=battle_marker,distance=..64] data.turn.menus.target[{Slot:6b}] unless entity @s[nbt={Items:[{Slot:6b}]}] run return run function test:battle/ui/cart_pick {screen:"target",slot:6,action:"target_minecart_toggle"}
execute if data entity @n[tag=battle_marker,distance=..64] data.turn.menus.target[{Slot:7b}] unless entity @s[nbt={Items:[{Slot:7b}]}] run return run function test:battle/ui/cart_pick {screen:"target",slot:7,action:"target_minecart_toggle"}

execute if data entity @n[tag=battle_marker,distance=..64] data.turn.menus.target[{Slot:8b}] unless entity @s[nbt={Items:[{Slot:8b}]}] run return run function test:battle/ui/cart_pick {screen:"target",slot:8,action:"target_minecart_resolve"}
