
execute store result score #level test.status.level run data get storage test: loot.item.components."minecraft:custom_data".level
execute store result score #max test.status.level run data get storage test: loot.item.components."minecraft:custom_data".max_level

execute if score #level test.status.level >= #max test.status.level run return fail

scoreboard players add #level test.status.level 1

execute store result score #status_bonus test.temporary run data get storage test: loot.item.components."minecraft:custom_data".status_bonus.value 100
execute store result score #base_status test.temporary run data get storage test: loot.item.components."minecraft:custom_data".base_status.value 100

data modify storage test: loot.temporary.status_bonus set from storage test: loot.item.components."minecraft:custom_data".status_bonus.type
data modify storage test: loot.temporary.base_status set from storage test: loot.item.components."minecraft:custom_data".base_status.type

function test:item/weapon/level_up/mainstatus with storage test: loot.temporary

execute store result storage test: loot.item.components."minecraft:custom_data".level int 1 run scoreboard players get #level test.status.level

scoreboard players operation #level test.temporary = #level test.status.level
scoreboard players operation #level test.temporary %= #10 test.constant

execute if score #level test.temporary matches 0 store result storage test: loot.temporary.substatus int 1 run random value -4..-1
execute if score #level test.temporary matches 0 run function test:item/weapon/level_up/substatus with storage test: loot.temporary

function test:item/weapon/level_up/set_name

function test:item/weapon/level_up/set_lore