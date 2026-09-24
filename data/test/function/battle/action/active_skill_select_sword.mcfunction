#> test:battle/action/active_skill_select_sword
# @s = 詠唱者(チャット式)。剣スキル(範囲攻撃)を番号1として一覧へ積む(存在するなら必ず最初に呼ばれる)

data modify storage test: battle.temporary.active_skill_slot append value {kind:"sword"}

tellraw @s [{text:"1: 剣技: 範囲攻撃",color:aqua,click_event:{action:"run_command",command:"/trigger test.battle.active_skill_select set 1"}}]
