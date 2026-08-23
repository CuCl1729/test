#> test:battle/ui/skill_type_minecart_toggle_apply
# @s = タイプアイコンを取ったプレイヤー。@macro slot_pick: 取られたスロットが表すタイプid
# 選択中なら外し、そうでなければ付ける(切り替え前の状態を先に控えてから書き換える)

function #oh_my_dat:please

scoreboard players set #was_selected test.temporary 0
$execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.select.type{$(slot_pick):1b} run scoreboard players set #was_selected test.temporary 1

$execute if score #was_selected test.temporary matches 1 run data remove storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.select.type.$(slot_pick)
$execute if score #was_selected test.temporary matches 0 run data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.select.type.$(slot_pick) set value 1b

# 拾ったアイコン自体は手元から消す(消費しないクラフター方式)
$clear @s *[custom_data~{test:{skill_choice:"$(slot_pick)"}}]
