#> test:battle/ui/chat
# @s = 現在手番のプレイヤー。チャットのクリックで行動を選択させる

scoreboard players set @s test.battle.chat_select 0
scoreboard players enable @s test.battle.chat_select

tellraw @s [{text:"あなたの番です。行動を選択してください",color:yellow}]
tellraw @s [{text:"[攻撃]",color:red,click_event:{action:"run_command",command:"/trigger test.battle.chat_select set 1"}}]
tellraw @s [{text:"[スキル]",color:light_purple,click_event:{action:"run_command",command:"/trigger test.battle.chat_select set 2"}}]
tellraw @s [{text:"[アイテム]",color:green,click_event:{action:"run_command",command:"/trigger test.battle.chat_select set 3"}}]
tellraw @s [{text:"[防御]",color:aqua,click_event:{action:"run_command",command:"/trigger test.battle.chat_select set 4"}}]
