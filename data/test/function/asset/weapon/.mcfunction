data modify storage test: loot.item.components.minecraft:piercing_weapon set value {}
data modify storage test: loot.item.components.minecraft:enchantments merge value {"test:trigger/left_click":1}
data modify storage test: loot.item.components.minecraft:custom_data.test merge value {left_click:1b}
data modify storage test: loot.item.components.minecraft:enchantment_glint_override set value 0b
data modify storage test: loot.item.components.minecraft:attack_range set value {min_reach:64,max_reach:64,min_creative_reach:64,max_creative_reach:64}

# 「範囲攻撃の核」で作成された場合、右クリックで扇状の範囲攻撃を発動できるようにする
# (倍率は作成時に一定範囲でランダム決定。半径は既存のreachをそのまま流用する)
# consumableが無いと右クリックが「使用」として検知されない(item/magic/give.mcfunctionの実装と同じ)
execute if data storage test: {loot:{aoe_core:1b}} run data modify storage test: loot.item.components.consumable set value {consume_seconds:100000,animation:none}
execute if data storage test: {loot:{aoe_core:1b}} run data modify storage test: loot.item.components.minecraft:custom_data.test merge value {right_click:true,aoe_attack:1b}
execute if data storage test: {loot:{aoe_core:1b}} run data modify storage test: loot.item.components.minecraft:custom_data.weapon append value {type:"aoe_angle",value:90}
execute if data storage test: {loot:{aoe_core:1b}} run data modify storage test: loot.item.components.minecraft:custom_data.weapon append value {type:"aoe_multiplier",value:0}
execute if data storage test: {loot:{aoe_core:1b}} store result storage test: loot.item.components.minecraft:custom_data.weapon[-1].value int 1 run random value 50..150

function test:loot/give