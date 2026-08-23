#> test:battle/ui/skill_type_display_line
# @s = タイプ選択中のプレイヤー(#oh_my_dat:pleaseは呼び出し元で実行済み)
# @macro id/label/color/index: レジストリの1件ぶん

$execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.known{$(id):1b} run return 0

$execute unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.select.type{$(id):1b} run tellraw @s [{text:"[無効] ",color:dark_gray},{text:"$(label)",color:"$(color)"},{text:" (クリックで選択)",color:gray,click_event:{action:"run_command",command:"/trigger test.battle.skill_select set $(index)"}}]
$execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.select.type{$(id):1b} run tellraw @s [{text:"[有効] ",color:green},{text:"$(label)",color:"$(color)"},{text:" (クリックで解除)",color:gray,click_event:{action:"run_command",command:"/trigger test.battle.skill_select set $(index)"}}]
