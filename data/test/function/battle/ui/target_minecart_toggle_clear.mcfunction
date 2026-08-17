#> test:battle/ui/target_minecart_toggle_clear
# @s = プレイヤー。$(clear_turn_order) = クリアする対象アイコンのturn_order

$clear @s minecraft:arrow[custom_data~{test:{target_pick:$(clear_turn_order)}}]
