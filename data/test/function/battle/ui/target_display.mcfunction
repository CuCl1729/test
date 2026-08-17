#> test:battle/ui/target_display
# 対象選択中の表示をやり直す(トグルの度に呼ばれる)。@sには依存しない(@aへ直接表示するため)

tellraw @a [{text:"攻撃対象を選んでください",color:light_purple}]

execute as @e[tag=battle_member,tag=enemy,distance=..64,scores={test.status.hp=1..}] run function test:battle/ui/target_display_target

tellraw @a [{text:"[決定]",color:aqua,click_event:{action:"run_command",command:"/trigger test.battle.target_select set 999"}}]
