#> test:battle/ui/target_minecart_resolve
# @s = 決定アイコンを取ったプレイヤー(トロッコ式)。@e[tag=battle_target]に選択済みの対象がいる想定

execute as @e[tag=target_minecart] run data remove entity @s Items
kill @e[tag=target_minecart]

clear @s minecraft:ender_eye[custom_data~{test:{target_pick:"confirm"}}]

# 投射魔法の対象選択から来た場合、ここでようやくskillアイテムを片付ける
# (通常攻撃からの場合はそもそも持っていないので無害)
clear @s minecraft:blaze_powder[custom_data~{test:{battle_action:"skill"}}]

scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.awaiting_target 0

execute if score @s test.battle.pending_target_action matches 1 run function test:battle/action/attack_resolve
execute if score @s test.battle.pending_target_action matches 2 run function test:battle/action/skill_cast/projectile_resolve
