#> test:battle/ui/skill_category_cart_tick
# @s = カテゴリ選択トロッコ本体(test:tickから毎tick呼ばれる)。自分のスロットが取られたか確認する

# 片方を処理したらその場で終える(「魔法」でタイプ一覧に作り替えた直後に次の行が新しい中身を見ると、
# タイプが1つだけのときスロット1が空なので「アクティブスキル」まで選んだ扱いになってしまう)
execute unless entity @s[nbt={Items:[{Slot:0b}]}] as @p[distance=..3] at @s run return run function test:battle/ui/skill_category_minecart_choice_magic
execute unless entity @s[nbt={Items:[{Slot:1b}]}] as @p[distance=..3] at @s run return run function test:battle/ui/skill_category_minecart_choice_active
