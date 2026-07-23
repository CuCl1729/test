data remove storage test: loot.item

data modify storage test: loot.item.id set value "minecraft:allay_spawn_egg"

data modify storage test: loot.item.components.entity_data set value {id:"armor_stand",Tags:["crafter",summoned],Invulnerable:1b,Invisible:0b,Marker:1b}

function test:loot/give