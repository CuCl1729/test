#> test:battle/ui/item_select
# @s = 行動を選んだプレイヤー。$(action) = 選んだ行動

clear @s minecraft:iron_sword[custom_data~{test:{battle_action:"attack"}}]
clear @s minecraft:blaze_powder[custom_data~{test:{battle_action:"skill"}}]
clear @s minecraft:potion[custom_data~{test:{battle_action:"item"}}]
clear @s minecraft:shield[custom_data~{test:{battle_action:"defend"}}]

$function test:battle/action/$(action)