#> test:battle/action/attack
# @s = 行動を選んだ攻撃者。対象を決定してからtest:battle/action/attack_resolveへ進む

# 敵(プレイヤーでない)の場合は今まで通り最も近いプレイヤーを自動選択する
execute unless entity @s[type=player] as @a[tag=battle_member,distance=..64,scores={test.status.hp=1..},sort=nearest,limit=1] run tag @s add battle_target
execute unless entity @s[type=player] run function test:battle/action/attack_resolve

# プレイヤーの場合、生存している敵の数を数える
execute if entity @s[type=player] run scoreboard players set #enemy_count test.temporary 0
execute if entity @s[type=player] as @e[tag=battle_member,tag=enemy,distance=..64,scores={test.status.hp=1..}] run scoreboard players add #enemy_count test.temporary 1

# 敵が1体だけなら選択UIを出さず自動でその1体に決定する
execute if entity @s[type=player] if score #enemy_count test.temporary matches 1 as @e[tag=battle_member,tag=enemy,distance=..64,scores={test.status.hp=1..},sort=nearest,limit=1] run tag @s add battle_target
execute if entity @s[type=player] if score #enemy_count test.temporary matches 1 run function test:battle/action/attack_resolve

# 敵が2体以上いる場合は対象選択UIを挟む
execute if entity @s[type=player] if score #enemy_count test.temporary matches 2.. run scoreboard players set @s test.battle.target_max 1
execute if entity @s[type=player] if score #enemy_count test.temporary matches 2.. run scoreboard players set @s test.battle.pending_target_action 1
execute if entity @s[type=player] if score #enemy_count test.temporary matches 2.. if score @s test.settings.battle_ui matches 1 run function test:battle/ui/target_select
execute if entity @s[type=player] if score #enemy_count test.temporary matches 2.. if score @s test.settings.battle_ui matches 2 run function test:battle/ui/target_minecart
