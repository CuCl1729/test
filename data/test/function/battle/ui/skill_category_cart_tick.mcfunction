#> test:battle/ui/skill_category_cart_tick
# @s = カテゴリ選択トロッコ本体(test:tickから毎tick呼ばれる)。自分のスロットが取られたか確認する

# 片方を処理したらその場で終える(「魔法」でタイプ一覧に作り替えた直後に次の行が新しい中身を見ると、
# タイプが1つだけのときスロット1が空なので「アクティブスキル」まで選んだ扱いになってしまう)
execute if data entity @n[tag=battle_marker,distance=..64] data.turn.menus.skill_category[{Slot:0b}] unless entity @s[nbt={Items:[{Slot:0b}]}] run return run function test:battle/ui/cart_pick {screen:"skill_category",slot:0,action:"skill_category_minecart_choice_magic"}
execute if data entity @n[tag=battle_marker,distance=..64] data.turn.menus.skill_category[{Slot:1b}] unless entity @s[nbt={Items:[{Slot:1b}]}] run return run function test:battle/ui/cart_pick {screen:"skill_category",slot:1,action:"skill_category_minecart_choice_active"}
