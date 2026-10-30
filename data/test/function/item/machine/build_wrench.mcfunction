#> test:item/machine/build_wrench
# loot.item をレンチにする。工場(サバイバル)で、筐体・搬入口・搬出口・核(#test:machine_breakable)をすぐ壊せる道具。
# correct_for_drops が無いと、入れ物や鉄ブロックなどは正しい道具でないとして何も落とさないので付ける。耐久値は減らない

data modify storage test: loot.item.components."minecraft:tool" set value {rules:[{blocks:"#test:machine_breakable",speed:30.0f,correct_for_drops:true}],damage_per_block:0}
data modify storage test: loot.item.components."minecraft:unbreakable" set value {}
data modify storage test: loot.item.components."minecraft:tooltip_display" set value {hidden_components:["minecraft:tool","minecraft:unbreakable","minecraft:attribute_modifiers"]}
