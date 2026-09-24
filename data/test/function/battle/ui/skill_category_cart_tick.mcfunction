#> test:battle/ui/skill_category_cart_tick
# @s = カテゴリ選択トロッコ本体(test:tickから毎tick呼ばれる)。自分のスロットが取られたか確認する

execute unless entity @s[nbt={Items:[{Slot:0b}]}] as @p[distance=..3] at @s run function test:battle/ui/skill_category_minecart_choice_magic
execute unless entity @s[nbt={Items:[{Slot:1b}]}] as @p[distance=..3] at @s run function test:battle/ui/skill_category_minecart_choice_active
