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
execute if data storage test: {loot:{aoe_core:1b}} run data modify storage test: loot.item.components.minecraft:custom_data.weapon append value {type:"aoe_mp_cost",value:20}

# 「毒の牙」で作成された場合、攻撃を当てたときに確率で毒を付与する
# 1件の形は魔法・敵と共通の {id,stacks,chance}(付与処理はtest:buff/apply_list)
execute if data storage test: {loot:{poison_fang:1b}} run data modify storage test: loot.item.components.minecraft:custom_data.test.buff_on_hit set value [{id:"poison",stacks:1,chance:30}]

function test:loot/give