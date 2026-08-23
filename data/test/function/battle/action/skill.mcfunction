#> test:battle/action/skill
# @s = 行動を選んだ詠唱者(チャット式)。研究ステーションで習得済みの魔法タイプを使って魔法を唱える
# (アイテム式はここを経由しない。スキルアイテムを手に持つだけでtest:battle/ui/skill_hover_tickが
#  トロッコを自動表示するため)
# 習得済みのタイプ数をレジストリ走査で数えるので、タイプを増やしてもここは無改修

function #oh_my_dat:please

scoreboard players set #known_type_count test.temporary 0
data remove storage test: registry_work.only_type
function test:magic/registry/queue_types
function test:battle/action/skill_known_loop

execute if score #known_type_count test.temporary matches 0 run tellraw @s [{text:"使える魔法がありません",color:gray}]
execute if score #known_type_count test.temporary matches 0 run return run function test:battle/turn_end

# 1つしか習得していない場合はタイプ選択を飛ばし、そのタイプを選択済みにして効果選択へ
execute if score #known_type_count test.temporary matches 1 run return run function test:battle/action/skill_single_type with storage test: registry_work.only_type

function test:battle/ui/skill_type_select
