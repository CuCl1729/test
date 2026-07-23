data remove storage test: loot.item

data modify storage test: loot.item.id set value nether_star

data modify storage test: loot.item.components.!minecraft:max_stack_size set value {}

data modify storage test: loot.item.components.minecraft:custom_data.test.right_click set value 1b
data modify storage test: loot.item.components.minecraft:custom_data.test.magic set value 1b
data modify storage test: loot.item.components.minecraft:custom_name set from storage test: magic.loot.name

data modify storage test: loot.item.components.consumable set value {consume_seconds:100000,animation:none}

data modify storage test: loot.item.components.minecraft:custom_data.test merge from storage test: magic.loot.status

execute store result storage test: loot.item.components.minecraft:custom_data.test.cost int 1 run scoreboard players get #cost test.temporary

function test:item/magic/set_lore

function test:loot/give
