#> test:item/magic/set_lore_flow
# storage test: loot.item に組み立てた魔法がつないだもの(custom_data.test.chain)なら、段の流れを1行で足す
execute unless data storage test: loot.item.components."minecraft:custom_data".test.chain[0] run return 0
data modify storage test: registry_work.flow set value [{text:"流れ: ",color:"gray",italic:false}]
data modify storage test: registry_work.flow_stage set from storage test: loot.item.components."minecraft:custom_data".test
function test:item/magic/flow_stage
data modify storage test: registry_work.flow_q set from storage test: loot.item.components."minecraft:custom_data".test.chain
function test:item/magic/flow_loop
data modify storage test: loot.item.components."minecraft:lore" append from storage test: registry_work.flow
