data modify storage test: loot.item.components.minecraft:piercing_weapon set value {}
data modify storage test: loot.item.components.minecraft:enchantments merge value {"test:trigger/left_click":1}
data modify storage test: loot.item.components.minecraft:custom_data.test merge value {left_click:1b}
data modify storage test: loot.item.components.minecraft:enchantment_glint_override set value 0b
data modify storage test: loot.item.components.minecraft:attack_range set value {min_reach:64,max_reach:64,min_creative_reach:64,max_creative_reach:64}

# 鍛冶で集めた特殊素材効果(forge_work.specials)をここで武器に適用する。鍛冶以外(forge_work.active無し)は何もしない
function test:action/material/apply
execute if score #material_invalid test.temporary matches 1 run return 0

# 性能・特殊効果まで書き終えたcustom_dataから説明文を作る
function test:item/weapon/lore/render

function test:loot/give