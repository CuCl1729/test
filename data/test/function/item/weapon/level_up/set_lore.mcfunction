data modify entity @n[tag=text] text set value {storage:"test:",nbt:"loot.item.components.minecraft:custom_data.base_status.value"}
data modify storage test: loot.item.components.minecraft:lore[0].extra[0].text set string entity @n[tag=text] text.extra[0].text 0 4

data modify entity @n[tag=text] text set value {storage:"test:",nbt:"loot.item.components.minecraft:custom_data.status_bonus.value"}
data modify storage test: loot.item.components.minecraft:lore[1].extra[0].text set string entity @n[tag=text] text.extra[0].text 0 4


data modify entity @n[tag=text] text set value {storage:"test:",nbt:"loot.item.components.minecraft:custom_data.substatus[0].value"}
execute if data storage test: loot.item.components.minecraft:lore.[3].extra[{text:"% "}] run data modify storage test: loot.item.components.minecraft:lore[3].extra[1].text set string entity @n[tag=text] text.extra[0].text 0 -1
execute unless data storage test: loot.item.components.minecraft:lore.[3].extra[{text:"% "}] run data modify storage test: loot.item.components.minecraft:lore[3].extra[1].text set string entity @n[tag=text] text.extra[0].text 0 -3

data modify entity @n[tag=text] text set value {storage:"test:",nbt:"loot.item.components.minecraft:custom_data.substatus[1].value"}
execute if data storage test: loot.item.components.minecraft:lore.[4].extra[{text:"% "}] run data modify storage test: loot.item.components.minecraft:lore[4].extra[1].text set string entity @n[tag=text] text.extra[0].text 0 -1
execute unless data storage test: loot.item.components.minecraft:lore.[4].extra[{text:"% "}] run data modify storage test: loot.item.components.minecraft:lore[4].extra[1].text set string entity @n[tag=text] text.extra[0].text 0 -3

data modify entity @n[tag=text] text set value {storage:"test:",nbt:"loot.item.components.minecraft:custom_data.substatus[2].value"}
execute if data storage test: loot.item.components.minecraft:lore.[5].extra[{text:"% "}] run data modify storage test: loot.item.components.minecraft:lore[5].extra[1].text set string entity @n[tag=text] text.extra[0].text 0 -1
execute unless data storage test: loot.item.components.minecraft:lore.[5].extra[{text:"% "}] run data modify storage test: loot.item.components.minecraft:lore[5].extra[1].text set string entity @n[tag=text] text.extra[0].text 0 -3

data modify entity @n[tag=text] text set value {storage:"test:",nbt:"loot.item.components.minecraft:custom_data.substatus[3].value"}
execute if data storage test: loot.item.components.minecraft:lore.[6].extra[{text:"% "}] run data modify storage test: loot.item.components.minecraft:lore[6].extra[1].text set string entity @n[tag=text] text.extra[0].text 0 -1
execute unless data storage test: loot.item.components.minecraft:lore.[6].extra[{text:"% "}] run data modify storage test: loot.item.components.minecraft:lore[6].extra[1].text set string entity @n[tag=text] text.extra[0].text 0 -3
