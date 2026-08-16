#> test:battle/ui/skill_effect_minecart_resolve
# @s = 詠唱確定アイコンを取ったプレイヤー(トロッコ式)

execute as @e[tag=skill_effect_minecart,distance=..3] run data remove entity @s Items
kill @e[tag=skill_effect_minecart,distance=..3]

# ここでようやくskillアイテム自体を片付ける(hover_tickの追従はもう不要なため)
clear @s minecraft:blaze_powder[custom_data~{test:{battle_action:"skill"}}]

# 拾った効果アイコン/確定アイコン自体を手元から消す
clear @s minecraft:ghast_tear[custom_data~{test:{skill_effect:"heal"}}]
clear @s minecraft:fire_charge[custom_data~{test:{skill_effect:"fire"}}]
clear @s minecraft:redstone[custom_data~{test:{skill_effect:"atk"}}]
clear @s minecraft:feather[custom_data~{test:{skill_effect:"gravity"}}]
clear @s minecraft:ender_eye[custom_data~{test:{skill_effect:"cast"}}]

function test:battle/ui/skill_effect_cast
