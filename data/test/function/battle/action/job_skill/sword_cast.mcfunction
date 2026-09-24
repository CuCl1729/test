#> test:battle/action/job_skill/sword_cast
# @s = 詠唱者(手番)。装備中の武器(範囲攻撃剣)のパラメータを使って、生存している敵全員へ
# 扇状範囲攻撃(atk×倍率)を当てる。ターン制には実際の位置関係が無いため対象選択を挟まない
# (これまで「攻撃」に特別扱いで乗っていたweapon_aoeの処理を、アクティブスキル側へ移したもの)

function #oh_my_dat:please

scoreboard players set #mp_cost test.job.work 0
execute store result score #mp_cost test.job.work run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".weapon[{type:"aoe_mp_cost"}].value

scoreboard players set #skill_sufficient test.temporary 0
execute if score @s test.status.mp >= #mp_cost test.job.work run scoreboard players set #skill_sufficient test.temporary 1

execute if score #skill_sufficient test.temporary matches 0 run tellraw @s [{text:"MPが足りません",color:gray}]
execute if score #skill_sufficient test.temporary matches 0 run return run function test:battle/turn_end

scoreboard players operation @s test.status.mp -= #mp_cost test.job.work

scoreboard players set #damage test.fire_damage 0
scoreboard players set #damage test.water_damage 0
scoreboard players set #damage test.wood_damage 0
scoreboard players set #damage test.metal_damage 0
scoreboard players set #damage test.earth_damage 0

scoreboard players operation #damage test.physics_damage = @s test.status.atk
scoreboard players set #multiplier test.job.work 0
execute store result score #multiplier test.job.work run data get storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".weapon[{type:"aoe_multiplier"}].value
scoreboard players operation #damage test.physics_damage *= #multiplier test.job.work
scoreboard players operation #damage test.physics_damage /= #100 test.constant

scoreboard players set #damage test.def.pene 0
scoreboard players operation #damage test.def.pene = @s test.def.pene
scoreboard players set #damage test.physics_resist.pene 0
scoreboard players operation #damage test.physics_resist.pene = @s test.physics_resist.pene

scoreboard players operation #damage test.status.crit_rate = @s test.status.crit_rate
scoreboard players operation #damage test.status.crit_damage = @s test.status.crit_damage
scoreboard players operation #damage test.status.crit_damage /= #100 test.constant

tellraw @a ["",{selector:"@s"},{text:" の範囲攻撃！",color:aqua}]

tag @s add damage_attacker
execute as @e[tag=battle_member,tag=enemy,distance=..64,scores={test.status.hp=1..}] run function test:battle/action/job_skill/hit_one
tag @s remove damage_attacker

function test:battle/turn_end
