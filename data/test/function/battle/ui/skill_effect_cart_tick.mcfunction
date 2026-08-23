#> test:battle/ui/skill_effect_cart_tick
# @s = 効果選択トロッコ本体(test:tickから毎tick呼ばれる)。自分のスロットが取られたか確認する
# (戦闘マーカー経由の手番判定は使わず、カートの近くにいるプレイヤー=所有者とする)
# スロット番号と効果idの対応はpopulate時にbattle.temporary.effect_slotへ控えてある

execute if data storage test: battle.temporary.effect_slot[0] unless entity @s[nbt={Items:[{Slot:0b}]}] as @p[distance=..3] at @s run function test:battle/ui/skill_effect_minecart_toggle {index:0}
execute if data storage test: battle.temporary.effect_slot[1] unless entity @s[nbt={Items:[{Slot:1b}]}] as @p[distance=..3] at @s run function test:battle/ui/skill_effect_minecart_toggle {index:1}
execute if data storage test: battle.temporary.effect_slot[2] unless entity @s[nbt={Items:[{Slot:2b}]}] as @p[distance=..3] at @s run function test:battle/ui/skill_effect_minecart_toggle {index:2}
execute if data storage test: battle.temporary.effect_slot[3] unless entity @s[nbt={Items:[{Slot:3b}]}] as @p[distance=..3] at @s run function test:battle/ui/skill_effect_minecart_toggle {index:3}
execute if data storage test: battle.temporary.effect_slot[4] unless entity @s[nbt={Items:[{Slot:4b}]}] as @p[distance=..3] at @s run function test:battle/ui/skill_effect_minecart_toggle {index:4}
execute if data storage test: battle.temporary.effect_slot[5] unless entity @s[nbt={Items:[{Slot:5b}]}] as @p[distance=..3] at @s run function test:battle/ui/skill_effect_minecart_toggle {index:5}
execute if data storage test: battle.temporary.effect_slot[6] unless entity @s[nbt={Items:[{Slot:6b}]}] as @p[distance=..3] at @s run function test:battle/ui/skill_effect_minecart_toggle {index:6}
execute if data storage test: battle.temporary.effect_slot[7] unless entity @s[nbt={Items:[{Slot:7b}]}] as @p[distance=..3] at @s run function test:battle/ui/skill_effect_minecart_toggle {index:7}

execute unless entity @s[nbt={Items:[{Slot:8b}]}] as @p[distance=..3] at @s run function test:battle/ui/skill_effect_minecart_resolve
