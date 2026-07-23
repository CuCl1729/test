data modify entity @n[tag=text] text set value {storage:"test:",nbt:"loot.item.components.minecraft:custom_data.level"}
data modify storage test: loot.item.components.minecraft:custom_name[2].text set from entity @n[tag=text] text.extra[0].text
