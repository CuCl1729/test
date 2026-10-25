
execute store result score #level test.status.level run data get storage test: loot.item.components."minecraft:custom_data".level
execute store result score #max test.status.level run data get storage test: loot.item.components."minecraft:custom_data".max_level

execute if score #level test.status.level >= #max test.status.level run return fail

scoreboard players add #level test.status.level 1

# 防具・アクセサリー(custom_data.equipあり)は、サブステータスを耐性込みの0..15から引く
data modify storage test: loot.substatus_max set value 9
execute if data storage test: loot.item.components."minecraft:custom_data".equip run data modify storage test: loot.substatus_max set value 15

function test:item/weapon/level_up/mainstatus

execute store result storage test: loot.item.components."minecraft:custom_data".level int 1 run scoreboard players get #level test.status.level

scoreboard players operation #level test.temporary = #level test.status.level
scoreboard players operation #level test.temporary %= #10 test.constant

execute if score #level test.temporary matches 0 store result storage test: loot.temporary.substatus int 1 run function test:rng/roll {key:"substatus_grow",min:-4,max:-1}
execute if score #level test.temporary matches 0 run function test:item/weapon/level_up/substatus with storage test: loot.temporary

function test:item/weapon/level_up/set_name

function test:item/weapon/lore/render