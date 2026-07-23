data modify storage test: loot.item.components.minecraft:piercing_weapon set value {}
data modify storage test: loot.item.components.minecraft:enchantments merge value {"test:trigger/left_click":1}
data modify storage test: loot.item.components.minecraft:custom_data.test merge value {left_click:1b}
data modify storage test: loot.item.components.minecraft:enchantment_glint_override set value 0b
data modify storage test: loot.item.components.minecraft:attack_range set value {min_reach:64,max_reach:64,min_creative_reach:64,max_creative_reach:64}

function test:loot/give