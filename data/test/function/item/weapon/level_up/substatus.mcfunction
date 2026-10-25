execute store result score #level test.temporary if data storage test: loot.item.components."minecraft:custom_data".substatus[]

execute unless score #level test.temporary matches 4.. run scoreboard players set #level test.substatus 1
execute unless score #level test.temporary matches 4.. store result storage test: loot.substatus int 1 run function test:loot/roll_substatus_type
execute unless score #level test.temporary matches 4.. run return run function test:loot/set_substatus with storage test: loot

function test:item/weapon/level_up/mainstatus

$data modify storage test: loot.temporary.type set from storage test: loot.item.components."minecraft:custom_data".substatus[$(substatus)].type

$execute store result score #status test.temporary run data get storage test: loot.item.components."minecraft:custom_data".substatus[$(substatus)].value 100

function test:item/weapon/level_up/add_substatus with storage test: loot.temporary
