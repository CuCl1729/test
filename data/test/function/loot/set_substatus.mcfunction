$data modify storage test: loot.temporary set from storage test: loot.table.substatus[$(substatus)]

function test:loot/check_substatus with storage test: loot.temporary

execute store result storage test: loot.substatus int 1 run function test:rng/roll {key:"substatus_type",min:0,max:9}

execute if score #loot test.boolean matches 0 run return run function test:loot/set_substatus with storage test: loot

scoreboard players remove #loot test.substatus 1

data modify storage test: loot.item.components."minecraft:custom_data".substatus append from storage test: loot.temporary
data modify storage test: loot.item.components."minecraft:custom_data".substatus[-1].grow set value 0
# 説明文はtest:item/weapon/lore/renderがcustom_dataから作り直すので、ここでは書かない

execute if score #loot test.substatus matches 1.. run function test:loot/set_substatus with storage test: loot

