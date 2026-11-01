#> test:item/scanner/build
# 観測鏡(右クリックを押し続けて調べる。test:research/scan/use)を loot.item に作る。
# 右クリックを拾うため consumable を付ける。持っている間はエンティティに触れる距離を0にする
# (敵・採取ポイントに向けて押しても、エンティティへの右クリックにならないように)

data remove storage test: loot.item
data modify storage test: loot.item set value {id:"minecraft:recovery_compass",components:{"minecraft:custom_data":{test:{right_click:true,scanner:1b}},"minecraft:custom_name":{text:"観測鏡",italic:false},"minecraft:item_model":"minecraft:spyglass","minecraft:max_stack_size":1,"minecraft:consumable":{consume_seconds:100000,animation:"spyglass"},"minecraft:attribute_modifiers":[{type:"minecraft:entity_interaction_range",id:"test:scanner",amount:-64.0d,operation:"add_value",slot:"mainhand",display:{type:"hidden"}}]}}
