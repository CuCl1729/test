#> test:battle/ui/skill_type_display_loop
# @s = タイプ選択中のプレイヤー。type_queueを末尾から取り出し、習得済みのタイプだけ1行ずつ表示する
# (#type_indexがそのタイプのトリガー値。習得していないタイプでも番号は進めることで、
#  習得状況が変わってもレジストリ内での番号が動かないようにする)

execute unless data storage test: registry_work.type_queue[-1] run return 0

data modify storage test: registry_work.type_entry set from storage test: registry_work.type_queue[-1]
data remove storage test: registry_work.type_queue[-1]

execute store result storage test: registry_work.type_entry.index int 1 run scoreboard players get #type_index test.temporary
function test:battle/ui/skill_type_display_line with storage test: registry_work.type_entry

scoreboard players add #type_index test.temporary 1
function test:battle/ui/skill_type_display_loop
