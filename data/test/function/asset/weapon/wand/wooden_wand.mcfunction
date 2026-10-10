data remove storage test: loot.item

data modify storage test: loot.item.id set from storage test: asset.wooden_wand.item

data modify storage test: loot.item.components set from storage test: asset.wooden_wand.components

execute unless data storage test: loot.item.components."minecraft:custom_data".substatus run data modify storage test: loot.item.components."minecraft:custom_data".substatus set value []

execute if data storage test: {loot:{rare:3}} store result score #loot test.substatus run function test:rng/roll {key:"substatus_count",min:1,max:2}
execute if data storage test: {loot:{rare:4}} store result score #loot test.substatus run function test:rng/roll {key:"substatus_count",min:2,max:3}
execute if data storage test: {loot:{rare:5}} store result score #loot test.substatus run function test:rng/roll {key:"substatus_count",min:3,max:4}

execute store result storage test: loot.substatus int 1 run function test:rng/roll {key:"substatus_type",min:0,max:9}

execute if data storage test: {loot:{rare:3}} run data modify storage test: loot.item.components."minecraft:custom_name"[0].color set value dark_aqua
execute if data storage test: {loot:{rare:4}} run data modify storage test: loot.item.components."minecraft:custom_name"[0].color set value dark_purple
execute if data storage test: {loot:{rare:5}} run data modify storage test: loot.item.components."minecraft:custom_name"[0].color set value gold

scoreboard players set #level test.status.level 0

function test:loot/set_substatus with storage test: loot
function test:asset/weapon/