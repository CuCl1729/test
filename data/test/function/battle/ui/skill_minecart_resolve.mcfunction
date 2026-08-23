#> test:battle/ui/skill_minecart_resolve
# @s = 「決定する」アイコンを取ったプレイヤー(トロッコ式)。タイプ選択を確定する

# トロッコ経由の確定はtest:battle/ui/item_selectを通らないため、他の行動アイテムをここで片付ける
# (skillアイテム自体はまだ手元に残す。効果選択カートが終わるまでhover_tickの追従に使うため、
#  実際に唱える直前のtest:battle/ui/skill_effect_minecart_resolveで片付ける)
clear @s minecraft:iron_sword[custom_data~{test:{battle_action:"attack"}}]
clear @s minecraft:potion[custom_data~{test:{battle_action:"item"}}]
clear @s minecraft:shield[custom_data~{test:{battle_action:"defend"}}]

# 決定アイコン自体も手元から消す
clear @s minecraft:ender_eye[custom_data~{test:{skill_choice:"confirm"}}]

# 組み合わせを検証する。不正ならタイプ選択のカートを詰め直してやり直させる
function #oh_my_dat:please

data remove storage test: registry_work.combo
data modify storage test: registry_work.combo.type_flags set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.select.type

scoreboard players set #delivery_count test.temporary 0
function test:magic/registry/queue_types
function test:battle/ui/skill_type_confirm_loop

execute unless data storage test: registry_work.combo.fallback run tellraw @s [{text:"タイプを1つ以上選んでください",color:gray}]
execute unless data storage test: registry_work.combo.fallback run return run function test:battle/ui/skill_type_minecart_populate

function test:magic/crafter/validate_combo

execute if score #combo_invalid test.temporary matches 1 run tellraw @s [{text:"その組み合わせでは詠唱できません",color:gray}]
execute if score #combo_invalid test.temporary matches 1 run return run function test:battle/ui/skill_type_minecart_populate

# デリバリタイプが選ばれていればそれを、修飾子タイプだけならそれ自身を届け方として使う
execute unless data storage test: registry_work.combo.delivery run data modify storage test: registry_work.combo.delivery set from storage test: registry_work.combo.fallback
data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.select.delivery set from storage test: registry_work.combo.delivery

# タイプが決まったので、続けて今回の詠唱で使う効果の組み合わせを選ばせる。
# トロッコを召喚し直さず、同じ実体を効果選択用として使い回す
tag @e[tag=skill_minecart,distance=..3] add skill_effect_minecart
scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.awaiting_skill 4

data remove storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.select.effect

function test:battle/ui/skill_effect_minecart_populate

tellraw @s [{text:"トロッコを開いて、使う効果を選び(複数可)最後に「詠唱する」を取ってください",color:light_purple}]
