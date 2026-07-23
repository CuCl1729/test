item replace block 0 -64 0 container.0 with stone

data modify block 0 -64 0 Items[{Slot:0b}] merge from storage test: loot.item
data modify block 0 -64 0 Items[{Slot:0b}].components."minecraft:tooltip_display".hidden_components append value "attribute_modifiers"
data modify block 0 -64 0 Items[{Slot:0b}].components."minecraft:tooltip_display".hidden_components append value "weapon"

loot spawn ~ ~ ~ mine 0 -64 0 debug_stick
execute if data storage test: loot{context:"give"} run data modify entity @n[type=item] PickupDelay set value 0
