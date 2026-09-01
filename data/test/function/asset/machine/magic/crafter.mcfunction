data remove storage test: loot.item

data modify storage test: loot.item.id set value "minecraft:allay_spawn_egg"

data modify storage test: loot.item.components.entity_data set value {id:"armor_stand",Tags:["crafter",summoned],Invulnerable:1b,Invisible:0b,Marker:1b,data:{crafter_ui:{page:0,has_next:0b,page_ids:[],build:[]}}}

function test:loot/give