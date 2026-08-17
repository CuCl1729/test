#> test:battle/ui/target_display_line
# @s = 表示対象の敵(1体)。$(turn_order) = そのturn_order

$execute if entity @s[tag=battle_target] run tellraw @a ["",{text:"[選択中] ",color:green},{selector:"@s"},{text:" (HP:",color:gray},{score:{name:"@s",objective:"test.status.hp"}},{text:") (クリックで解除)",color:gray,click_event:{action:"run_command",command:"/trigger test.battle.target_select set $(turn_order)"}}]
$execute unless entity @s[tag=battle_target] run tellraw @a ["",{text:"[未選択] ",color:dark_gray},{selector:"@s"},{text:" (HP:",color:gray},{score:{name:"@s",objective:"test.status.hp"}},{text:") (クリックで選択)",color:gray,click_event:{action:"run_command",command:"/trigger test.battle.target_select set $(turn_order)"}}]
