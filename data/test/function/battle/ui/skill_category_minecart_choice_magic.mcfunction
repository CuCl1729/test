#> test:battle/ui/skill_category_minecart_choice_magic
# @s = 「魔法」を選んだプレイヤー(トロッコ式)。同じカートのタグを付け替えて中身を作り替える
# (target_minecart.mcfunctionと同じ使い回しの手法)

tag @e[tag=skill_category_minecart,distance=..8] remove skill_category_minecart
clear @s *[custom_data~{test:{skill_category:"magic"}}]
clear @s *[custom_data~{test:{skill_category:"active"}}]

function test:battle/ui/skill_type_minecart_populate
