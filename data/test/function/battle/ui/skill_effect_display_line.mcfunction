#> test:battle/ui/skill_effect_display_line
# @s = 表示対象のプレイヤー(チャット式)
# $(effect)=効果名 $(trigger)=トグル用トリガー値 $(label)=表示名 $(color)=表示色

$execute if score @s test.magic.select.$(effect) matches 1 run tellraw @s [{text:"[有効] ",color:green},{text:"$(label)",color:$(color)},{text:" (クリックで解除)",color:gray,click_event:{action:"run_command",command:"/trigger test.battle.skill_effect set $(trigger)"}}]
$execute if score @s test.magic.select.$(effect) matches 0 run tellraw @s [{text:"[無効] ",color:dark_gray},{text:"$(label)",color:$(color)},{text:" (クリックで選択)",color:gray,click_event:{action:"run_command",command:"/trigger test.battle.skill_effect set $(trigger)"}}]
