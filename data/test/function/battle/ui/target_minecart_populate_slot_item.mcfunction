#> test:battle/ui/target_minecart_populate_slot_item
# @s = 表示対象の敵(1体)。$(turn_order)=そのturn_order $(item_slot)=詰めるスロット番号

$execute if entity @s[tag=battle_target] run data modify entity @n[tag=target_minecart] Items append value {Slot:$(item_slot)b,id:"arrow",count:1,components:{"minecraft:custom_name":{text:"[選択中] 対象",italic:false,color:"green"},"minecraft:custom_data":{test:{target_pick:$(turn_order)}}}}
$execute unless entity @s[tag=battle_target] run data modify entity @n[tag=target_minecart] Items append value {Slot:$(item_slot)b,id:"arrow",count:1,components:{"minecraft:custom_name":{text:"[未選択] 対象",italic:false},"minecraft:custom_data":{test:{target_pick:$(turn_order)}}}}
