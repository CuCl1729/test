#> test:battle/ui/skill_effect_minecart_resolve
# @s = 詠唱確定アイコンを取ったプレイヤー(トロッコ式)

# 拾った効果アイコン/確定アイコン自体を手元から消す(どちらのルートでも不要)
clear @s *[custom_data~{test:{skill_effect:"cast"}}]
function test:battle/ui/skill_effect_minecart_clear

function #oh_my_dat:please

# 対象を1体選ばせる必要があるのは「投射」で、かつ「範囲」と組み合わせていない場合だけ
scoreboard players set #needs_target test.temporary 0
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.select{delivery:"projectile"} unless data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.magic.select.type{aoe:1b} run scoreboard players set #needs_target test.temporary 1

scoreboard players set #enemy_count test.temporary 0
execute if score #needs_target test.temporary matches 1 as @e[tag=battle_member,tag=enemy,distance=..64,scores={test.status.hp=1..}] run scoreboard players add #enemy_count test.temporary 1

# 敵が2体以上いる場合だけ、トロッコを召喚し直さず対象選択用に変換して継続する
execute if score #enemy_count test.temporary matches 2.. run scoreboard players set @s test.battle.target_max 1
execute if score #enemy_count test.temporary matches 2.. run scoreboard players set @s test.battle.pending_target_action 2
execute if score #enemy_count test.temporary matches 2.. run function test:battle/ui/target_minecart
execute if score #enemy_count test.temporary matches 2.. run return 0

# 敵が1体以下、または対象選択が不要な場合はここでカートを片付けて即詠唱する
execute if score #enemy_count test.temporary matches 1 as @e[tag=battle_member,tag=enemy,distance=..64,scores={test.status.hp=1..},sort=nearest,limit=1] run tag @s add battle_target

execute as @e[tag=skill_effect_minecart,distance=..3] run data remove entity @s Items
kill @e[tag=skill_effect_minecart,distance=..3]

# ここでようやくskillアイテム自体を片付ける(hover_tickの追従はもう不要なため)
clear @s minecraft:blaze_powder[custom_data~{test:{battle_action:"skill"}}]

function test:battle/ui/skill_effect_cast
