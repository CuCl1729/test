#> test:battle/ui/cart_stamp_loop
execute unless data storage test: battle_ui.slots[0] run return 0
data modify storage test: battle_ui.stamp.slot set from storage test: battle_ui.slots[0].Slot
data remove storage test: battle_ui.slots[0]
function test:battle/ui/cart_stamp with storage test: battle_ui.stamp
function test:battle/ui/cart_stamp_loop
