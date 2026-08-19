#> test:battle/ui/attack_hover_show
# @s = 攻撃アイテム(鉄の剣)を持っているプレイヤー。敵が2体以上生存している場合のみ、
# 対象選択トロッコをあらかじめ召喚しておく(1体の場合は右クリックでこれまで通り即時攻撃するため何もしない)
# 範囲攻撃剣(test.battle.weapon_aoe)を装備している場合はそもそも対象を選ぶ必要が無いため出さない
# 既にトロッコが出ている間は毎tick詰め直さない(選択中のスロット表示が巻き戻ってしまうため)

execute unless entity @e[tag=skill_minecart,distance=..3] unless score @s test.battle.weapon_aoe matches 1 run scoreboard players set #enemy_count test.temporary 0
execute unless entity @e[tag=skill_minecart,distance=..3] unless score @s test.battle.weapon_aoe matches 1 as @e[tag=battle_member,tag=enemy,distance=..64,scores={test.status.hp=1..}] run scoreboard players add #enemy_count test.temporary 1

execute unless entity @e[tag=skill_minecart,distance=..3] unless score @s test.battle.weapon_aoe matches 1 if score #enemy_count test.temporary matches 2.. run scoreboard players set @s test.battle.target_max 1
execute unless entity @e[tag=skill_minecart,distance=..3] unless score @s test.battle.weapon_aoe matches 1 if score #enemy_count test.temporary matches 2.. run scoreboard players set @s test.battle.pending_target_action 1
execute unless entity @e[tag=skill_minecart,distance=..3] unless score @s test.battle.weapon_aoe matches 1 if score #enemy_count test.temporary matches 2.. run function test:battle/ui/target_minecart
