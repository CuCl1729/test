#> test:battle/ui/skill_effect_cart_tick
# @s = 効果選択トロッコ本体(test:tickから毎tick呼ばれる)。自分のスロットが取られたか確認する
# (戦闘マーカー経由の手番判定は使わず、カートの近くにいるプレイヤー=所有者とする)

execute if score @p[distance=..3] test.battle.skill_type matches 1 unless entity @s[nbt={Items:[{Slot:0b}]}] as @p[distance=..3] at @s run function test:battle/ui/skill_effect_minecart_toggle {effect:"heal",item:"ghast_tear"}

execute if score @p[distance=..3] test.battle.skill_type matches 2 unless entity @s[nbt={Items:[{Slot:0b}]}] as @p[distance=..3] at @s run function test:battle/ui/skill_effect_minecart_toggle {effect:"fire",item:"fire_charge"}
execute if score @p[distance=..3] test.battle.skill_type matches 2 unless entity @s[nbt={Items:[{Slot:1b}]}] as @p[distance=..3] at @s run function test:battle/ui/skill_effect_minecart_toggle {effect:"atk",item:"redstone"}
execute if score @p[distance=..3] test.battle.skill_type matches 2 unless entity @s[nbt={Items:[{Slot:2b}]}] as @p[distance=..3] at @s run function test:battle/ui/skill_effect_minecart_toggle {effect:"gravity",item:"feather"}

execute unless entity @s[nbt={Items:[{Slot:8b}]}] as @p[distance=..3] at @s run function test:battle/ui/skill_effect_minecart_resolve
