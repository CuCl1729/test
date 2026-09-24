#> test:battle/action/active_skill_queue_line
# @s = 詠唱者(チャット式)。@macro label/index: job_work.skill_entryから展開済み。
# クリック可能な一覧行を1つ表示する(skill_type_display_lineと同じ形)

$tellraw @s [{text:"$(index): $(label)",color:"light_purple",click_event:{action:"run_command",command:"/trigger test.battle.active_skill_select set $(index)"}}]
