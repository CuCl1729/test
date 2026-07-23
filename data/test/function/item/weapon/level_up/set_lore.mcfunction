data modify entity @n[tag=text] text set value {storage:"test:",nbt:"loot.item.components.minecraft:custom_data.base_status.value"}
data modify storage test: loot.item.components.minecraft:lore[0][1].text set string entity @n[tag=text] text.extra[0].text 0 4

data modify entity @n[tag=text] text set value {storage:"test:",nbt:"loot.item.components.minecraft:custom_data.status_bonus.value"}
data modify storage test: loot.item.components.minecraft:lore[1][1].text set string entity @n[tag=text] text.extra[0].text 0 4


data modify entity @n[tag=text] text set value {storage:"test:",nbt:"loot.item.components.minecraft:custom_data.substatus[0].value"}
execute if data storage test: loot.item.components.minecraft:lore.[3][{text:"% "}] run data modify storage test: loot.item.components.minecraft:lore[3][2].text set string entity @n[tag=text] text.extra[0].text 0 -1
execute unless data storage test: loot.item.components.minecraft:lore.[3][{text:"% "}] run data modify storage test: loot.item.components.minecraft:lore[3][2].text set string entity @n[tag=text] text.extra[0].text 0 -3

data modify entity @n[tag=text] text set value {storage:"test:",nbt:"loot.item.components.minecraft:custom_data.substatus[1].value"}
execute if data storage test: loot.item.components.minecraft:lore.[4][{text:"% "}] run data modify storage test: loot.item.components.minecraft:lore[4][2].text set string entity @n[tag=text] text.extra[0].text 0 -1
execute unless data storage test: loot.item.components.minecraft:lore.[4][{text:"% "}] run data modify storage test: loot.item.components.minecraft:lore[4][2].text set string entity @n[tag=text] text.extra[0].text 0 -3

data modify entity @n[tag=text] text set value {storage:"test:",nbt:"loot.item.components.minecraft:custom_data.substatus[2].value"}
execute if data storage test: loot.item.components.minecraft:lore.[5][{text:"% "}] run data modify storage test: loot.item.components.minecraft:lore[5][2].text set string entity @n[tag=text] text.extra[0].text 0 -1
execute unless data storage test: loot.item.components.minecraft:lore.[5][{text:"% "}] run data modify storage test: loot.item.components.minecraft:lore[5][2].text set string entity @n[tag=text] text.extra[0].text 0 -3

data modify entity @n[tag=text] text set value {storage:"test:",nbt:"loot.item.components.minecraft:custom_data.substatus[3].value"}
execute if data storage test: loot.item.components.minecraft:lore.[6][{text:"% "}] run data modify storage test: loot.item.components.minecraft:lore[6][2].text set string entity @n[tag=text] text.extra[0].text 0 -1
execute unless data storage test: loot.item.components.minecraft:lore.[6][{text:"% "}] run data modify storage test: loot.item.components.minecraft:lore[6][2].text set string entity @n[tag=text] text.extra[0].text 0 -3
