#> test:battle/ui/skill_type_confirm
# @s = タイプ選択を決定したプレイヤー(チャット式/トロッコ式共通)
# 選択の組み合わせを検証し、妥当ならデリバリタイプを控えて効果選択へ進む

function #oh_my_dat:please

# 検証はクラフト時と同じレジストリ駆動のルールを使う。選択状態を検証用の形へ写してから判定する
data remove storage test: registry_work.combo
data modify storage test: registry_work.combo.type_flags set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.select.type

scoreboard players set #delivery_count test.temporary 0
function test:magic/registry/queue_types
function test:battle/ui/skill_type_confirm_loop

execute unless data storage test: registry_work.combo.fallback run tellraw @s [{text:"タイプを1つ以上選んでください",color:gray}]
execute unless data storage test: registry_work.combo.fallback run return run function test:battle/ui/skill_type_display

function test:magic/crafter/validate_combo

execute if score #combo_invalid test.temporary matches 1 run tellraw @s [{text:"その組み合わせでは詠唱できません",color:gray}]
execute if score #combo_invalid test.temporary matches 1 run return run function test:battle/ui/skill_type_display

# デリバリタイプが選ばれていればそれを、修飾子タイプだけならそれ自身を届け方として使う
execute unless data storage test: registry_work.combo.delivery run data modify storage test: registry_work.combo.delivery set from storage test: registry_work.combo.fallback
data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.select.delivery set from storage test: registry_work.combo.delivery

function test:battle/ui/skill_effect_select
