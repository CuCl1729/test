#> test:battle/ui/skill_effect_display
# @s = 効果選択中のプレイヤー(チャット式)。現在の選択状態を表示し直す(トグルの度に呼ばれる)

tellraw @s [{text:"使う効果を選んでください(複数選択可)",color:light_purple}]

execute if score @s test.battle.skill_type matches 1 if score @s test.magic.known.heal matches 1 run function test:battle/ui/skill_effect_display_line {effect:"heal",trigger:3,label:"回復",color:"white"}

execute if score @s test.battle.skill_type matches 2 if score @s test.magic.known.fire matches 1 run function test:battle/ui/skill_effect_display_line {effect:"fire",trigger:1,label:"火炎",color:"red"}
execute if score @s test.battle.skill_type matches 2 if score @s test.magic.known.atk matches 1 run function test:battle/ui/skill_effect_display_line {effect:"atk",trigger:2,label:"威力上昇",color:"gold"}
execute if score @s test.battle.skill_type matches 2 if score @s test.magic.known.gravity matches 1 run function test:battle/ui/skill_effect_display_line {effect:"gravity",trigger:4,label:"重力",color:"gray"}

tellraw @s [{text:"[詠唱する]",color:aqua,click_event:{action:"run_command",command:"/trigger test.battle.skill_effect set 5"}}]
