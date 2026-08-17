#> test:battle/action/skill_cast/projectile
# @s = 詠唱者。対象を決定してからtest:battle/action/skill_cast/projectile_resolveへ進む
# (アイテム式は効果選択トロッコの確定時に対象決定済みなのでここを経由しない。test:battle/ui/skill_effect_cast参照)

execute unless entity @s[type=player] as @a[tag=battle_member,distance=..64,scores={test.status.hp=1..},sort=nearest,limit=1] run tag @s add battle_target
execute unless entity @s[type=player] run function test:battle/action/skill_cast/projectile_resolve

execute if entity @s[type=player] run scoreboard players set #enemy_count test.temporary 0
execute if entity @s[type=player] as @e[tag=battle_member,tag=enemy,distance=..64,scores={test.status.hp=1..}] run scoreboard players add #enemy_count test.temporary 1

execute if entity @s[type=player] if score #enemy_count test.temporary matches 1 as @e[tag=battle_member,tag=enemy,distance=..64,scores={test.status.hp=1..},sort=nearest,limit=1] run tag @s add battle_target
execute if entity @s[type=player] if score #enemy_count test.temporary matches 1 run function test:battle/action/skill_cast/projectile_resolve

execute if entity @s[type=player] if score #enemy_count test.temporary matches 2.. run scoreboard players set @s test.battle.target_max 1
execute if entity @s[type=player] if score #enemy_count test.temporary matches 2.. run scoreboard players set @s test.battle.pending_target_action 2
execute if entity @s[type=player] if score #enemy_count test.temporary matches 2.. run function test:battle/ui/target_select
