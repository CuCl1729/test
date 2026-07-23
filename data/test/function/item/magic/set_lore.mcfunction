data modify storage test: loot.item.components.minecraft:lore append value [{italic:0b,color:gray,text:"消費MP:"}]
data modify entity @n[tag=text] text set value {color:aqua,type:"nbt",storage:"test:",nbt:"loot.item.components.minecraft:custom_data.test.cost"}
data modify storage test: loot.item.components.minecraft:lore[0] append from entity @n[tag=text] text
