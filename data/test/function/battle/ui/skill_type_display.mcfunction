#> test:battle/ui/skill_type_display
# @s = タイプ選択中のプレイヤー(チャット式)。現在の選択状態を表示し直す(トグルの度に呼ばれる)
# レジストリ(test:init/asset/magic/types)を走査するので、タイプを増やしてもここは無改修

tellraw @s [{text:"使う魔法のタイプを選んでください(組み合わせ可)",color:light_purple}]

function #oh_my_dat:please

# トリガー値としてレジストリの並び順(1始まり)を使う
scoreboard players set #type_index test.temporary 1
function test:magic/registry/queue_types
function test:battle/ui/skill_type_display_loop

tellraw @s [{text:"[決定]",color:aqua,click_event:{action:"run_command",command:"/trigger test.battle.skill_select set 99"}}]
