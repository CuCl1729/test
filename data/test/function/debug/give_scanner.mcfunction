#> test:debug/give_scanner
# @s = プレイヤー。観測鏡(右クリックを押し続けて調べる。test:research/scan/use)を渡す。
# 右クリックを拾うため、ステータス確認のアイテムと同じく consumable を付ける(使い終わらないほど長い時間)。
# 持っている間はエンティティに触れる距離を0にする(敵・採取ポイントに向けて押しても、エンティティへの右クリックにならないように)

give @s minecraft:recovery_compass[custom_data={test:{right_click:true,scanner:1b}},custom_name={text:"観測鏡",italic:false},item_model="minecraft:spyglass",max_stack_size=1,consumable={consume_seconds:100000,animation:spyglass},attribute_modifiers=[{type:"minecraft:entity_interaction_range",id:"test:scanner",amount:-64.0d,operation:"add_value",slot:"mainhand",display:{type:"hidden"}}]]
