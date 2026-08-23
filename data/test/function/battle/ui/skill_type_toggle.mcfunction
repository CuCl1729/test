#> test:battle/ui/skill_type_toggle
# @s = タイプをトグルしたプレイヤー。@macro id: 切り替えるタイプid
# 選択中なら外し、そうでなければ付ける。切り替え前の状態を先に控えてから書き換える
# (書き換えた後の値を見て逆判定してしまうのを防ぐため)

function #oh_my_dat:please

scoreboard players set #was_selected test.temporary 0
$execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.select.type{$(id):1b} run scoreboard players set #was_selected test.temporary 1

$execute if score #was_selected test.temporary matches 1 run data remove storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.select.type.$(id)
$execute if score #was_selected test.temporary matches 0 run data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.select.type.$(id) set value 1b
