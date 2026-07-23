item replace block 0 -64 0 container.0 with stone

data modify block 0 -64 0 Items[{Slot:0b}] merge from storage test: loot.item
data modify block 0 -64 0 Items[{Slot:0b}].components."minecraft:tooltip_display".hidden_components append value "attribute_modifiers"
data modify block 0 -64 0 Items[{Slot:0b}].components."minecraft:tooltip_display".hidden_components append value "weapon"

loot replace entity @s weapon.mainhand 1 mine 0 -64 0 debug_stick
