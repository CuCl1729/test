#> test:battle/ui/skill_effect_display
# @s = 効果選択中のプレイヤー(チャット式)。現在の選択状態を表示し直す(トグルの度に呼ばれる)

tellraw @s [{text:"使う効果を選んでください(複数選択可)",color:light_purple}]

execute if score @s test.battle.skill_type matches 1 if score @s test.magic.known.heal matches 1 run function test:battle/ui/skill_effect_display_line {effect:"heal",trigger:3,label:"回復",color:"white"}

execute if score @s test.battle.skill_type matches 2 if score @s test.magic.known.fire matches 1 run function test:battle/ui/skill_effect_display_line {effect:"fire",trigger:1,label:"火炎",color:"red"}
# 威力上昇は0〜3の重ね掛け段階を持つため、専用の表示にする(クリックの度に0→1→2→3→0と循環)
execute if score @s test.battle.skill_type matches 2 if score @s test.magic.known.atk matches 1 if score @s test.magic.select.atk matches 0 run tellraw @s [{text:"[無効] ",color:dark_gray},{text:"威力上昇",color:gold},{text:" (クリックで選択)",color:gray,click_event:{action:"run_command",command:"/trigger test.battle.skill_effect set 2"}}]
execute if score @s test.battle.skill_type matches 2 if score @s test.magic.known.atk matches 1 if score @s test.magic.select.atk matches 1 run tellraw @s [{text:"[有効] ",color:green},{text:"威力上昇 ×1",color:gold},{text:" (クリックで重ねる)",color:gray,click_event:{action:"run_command",command:"/trigger test.battle.skill_effect set 2"}}]
execute if score @s test.battle.skill_type matches 2 if score @s test.magic.known.atk matches 1 if score @s test.magic.select.atk matches 2 run tellraw @s [{text:"[有効] ",color:green},{text:"威力上昇 ×2",color:gold},{text:" (クリックで重ねる)",color:gray,click_event:{action:"run_command",command:"/trigger test.battle.skill_effect set 2"}}]
execute if score @s test.battle.skill_type matches 2 if score @s test.magic.known.atk matches 1 if score @s test.magic.select.atk matches 3 run tellraw @s [{text:"[有効] ",color:green},{text:"威力上昇 ×3",color:gold},{text:" (クリックで解除)",color:gray,click_event:{action:"run_command",command:"/trigger test.battle.skill_effect set 2"}}]
execute if score @s test.battle.skill_type matches 2 if score @s test.magic.known.gravity matches 1 run function test:battle/ui/skill_effect_display_line {effect:"gravity",trigger:4,label:"重力",color:"gray"}

tellraw @s [{text:"[詠唱する]",color:aqua,click_event:{action:"run_command",command:"/trigger test.battle.skill_effect set 5"}}]
