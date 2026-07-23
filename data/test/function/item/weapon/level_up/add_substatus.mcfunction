$execute store result score #substatus test.temporary run data get storage test: loot.table.substatus[{type:"$(type)"}].value 100

scoreboard players operation #substatus test.temporary += #status test.temporary

$execute store result storage test: loot.item.components."minecraft:custom_data".substatus[$(substatus)].value double 0.01 run scoreboard players get #substatus test.temporary

$data modify storage test: loot.item.components."minecraft:lore"[$(substatus)][{text:"+9"}] set value {italic:false,color:gold,text:"+10"}
$data modify storage test: loot.item.components."minecraft:lore"[$(substatus)][{text:"+8"}] set value {italic:false,color:gold,text:"+9"}
$data modify storage test: loot.item.components."minecraft:lore"[$(substatus)][{text:"+7"}] set value {italic:false,color:gold,text:"+8"}
$data modify storage test: loot.item.components."minecraft:lore"[$(substatus)][{text:"+6"}] set value {italic:false,color:gold,text:"+7"}
$data modify storage test: loot.item.components."minecraft:lore"[$(substatus)][{text:"+5"}] set value {italic:false,color:gold,text:"+6"}
$data modify storage test: loot.item.components."minecraft:lore"[$(substatus)][{text:"+4"}] set value {italic:false,color:gold,text:"+5"}
$data modify storage test: loot.item.components."minecraft:lore"[$(substatus)][{text:"+3"}] set value {italic:false,color:gold,text:"+4"}
$data modify storage test: loot.item.components."minecraft:lore"[$(substatus)][{text:"+2"}] set value {italic:false,color:gold,text:"+3"}
$data modify storage test: loot.item.components."minecraft:lore"[$(substatus)][{text:"+1"}] set value {italic:false,color:gold,text:"+2"}
$execute unless data storage test: loot.item.components."minecraft:lore"[$(substatus)][4] run data modify storage test: loot.item.components."minecraft:lore"[$(substatus)] append value {italic:false,color:gold,text:"+1"}
