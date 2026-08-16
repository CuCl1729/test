#> test:battle/ui/skill_minecart_resolve
# @s = 戦闘マーカー。$(type) = 選ばれた魔法タイプ(self|projectile)

scoreboard players operation #battle_turn test.battle.id = @s test.battle.id
scoreboard players operation #battle_turn test.battle.current_turn = @s test.battle.current_turn

scoreboard players set @s test.battle.awaiting_skill 0

execute as @e[tag=skill_minecart] run data remove entity @s Items
kill @e[tag=skill_minecart]

# トロッコ経由の確定はtest:battle/ui/item_selectを通らないため、他の行動アイテムをここで片付ける
execute at @s as @a[tag=battle_member,distance=..64] if score @s test.battle.id = #battle_turn test.battle.id if score @s test.battle.turn_order = #battle_turn test.battle.current_turn run clear @s minecraft:iron_sword[custom_data~{test:{battle_action:"attack"}}]
execute at @s as @a[tag=battle_member,distance=..64] if score @s test.battle.id = #battle_turn test.battle.id if score @s test.battle.turn_order = #battle_turn test.battle.current_turn run clear @s minecraft:blaze_powder[custom_data~{test:{battle_action:"skill"}}]
execute at @s as @a[tag=battle_member,distance=..64] if score @s test.battle.id = #battle_turn test.battle.id if score @s test.battle.turn_order = #battle_turn test.battle.current_turn run clear @s minecraft:potion[custom_data~{test:{battle_action:"item"}}]
execute at @s as @a[tag=battle_member,distance=..64] if score @s test.battle.id = #battle_turn test.battle.id if score @s test.battle.turn_order = #battle_turn test.battle.current_turn run clear @s minecraft:shield[custom_data~{test:{battle_action:"defend"}}]

# トロッコから拾った選択用アイコン自体も手元から消す
execute at @s as @a[tag=battle_member,distance=..64] if score @s test.battle.id = #battle_turn test.battle.id if score @s test.battle.turn_order = #battle_turn test.battle.current_turn run clear @s minecraft:glass_bottle[custom_data~{test:{skill_choice:"self"}}]
execute at @s as @a[tag=battle_member,distance=..64] if score @s test.battle.id = #battle_turn test.battle.id if score @s test.battle.turn_order = #battle_turn test.battle.current_turn run clear @s minecraft:snowball[custom_data~{test:{skill_choice:"projectile"}}]

$execute at @s as @a[tag=battle_member,distance=..64] if score @s test.battle.id = #battle_turn test.battle.id if score @s test.battle.turn_order = #battle_turn test.battle.current_turn run function test:battle/action/skill_cast/$(type)
