#> test:item/machine/build_wrench
# loot.item をレンチにする。部品・入れ物・核・ホッパーだけを壊せて(can_break)、すぐ壊れる。
# correct_for_drops が無いと、入れ物などは正しい道具でないとして何も落とさないので付ける。耐久値は減らない

data modify storage test: loot.item.components."minecraft:can_break" set value {blocks:"#test:machine_breakable"}
data modify storage test: loot.item.components."minecraft:tool" set value {rules:[{blocks:"#test:machine_breakable",speed:30.0f,correct_for_drops:true}],damage_per_block:0}
data modify storage test: loot.item.components."minecraft:unbreakable" set value {}
data modify storage test: loot.item.components."minecraft:tooltip_display" set value {hidden_components:["minecraft:can_break","minecraft:tool","minecraft:unbreakable","minecraft:attribute_modifiers"]}
