execute in minecraft:overworld run item replace block 0 -64 0 container.0 with stone

execute in minecraft:overworld run data modify block 0 -64 0 Items[{Slot:0b}] merge from storage test: loot.item
execute in minecraft:overworld run data modify block 0 -64 0 Items[{Slot:0b}].components."minecraft:tooltip_display".hidden_components append value "attribute_modifiers"
execute in minecraft:overworld run data modify block 0 -64 0 Items[{Slot:0b}].components."minecraft:tooltip_display".hidden_components append value "weapon"

# 組み立て自体はオーバーワールドの 0 -64 0 で行い、できたアイテムを呼び出し元(@s)の位置・次元へ転送する
execute in minecraft:overworld run loot spawn 0 -64 1 mine 0 -64 0 debug_stick
execute in minecraft:overworld run tp @n[type=item] @s

execute if data storage test: loot{context:"give"} run data modify entity @n[type=item] PickupDelay set value 0
