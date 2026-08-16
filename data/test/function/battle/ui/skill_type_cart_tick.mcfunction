#> test:battle/ui/skill_type_cart_tick
# @s = タイプ選択トロッコ本体(test:tickから毎tick呼ばれる)。自分のスロットが取られたか確認する
# (取った瞬間に即決定。戦闘マーカー経由の手番判定は使わず、カートの近くにいるプレイヤー=所有者とする)

execute unless entity @s[nbt={Items:[{Slot:0b}]}] as @p[distance=..3] at @s run function test:battle/ui/skill_minecart_resolve {type:1}
execute unless entity @s[nbt={Items:[{Slot:1b}]}] as @p[distance=..3] at @s run function test:battle/ui/skill_minecart_resolve {type:2}
