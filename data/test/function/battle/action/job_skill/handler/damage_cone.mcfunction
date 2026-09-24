#> test:battle/action/job_skill/handler/damage_cone
# @s = 詠唱者(手番)。@macro angle/multiplier/mp_cost/reach: このスキルのparamsがそのまま
# macro展開されている(angle/reachはターン制では対象選択が無いため見た目上使わない。
# リアルタイムと宣言を共通にするため受け取るだけ)。ターン制には実際の位置関係が無いため、
# 生存している敵全員へ当てる(test:battle/action/skill_cast/aoeと同じ「対象選択を挟まず全体に
# 当てる」形)。装備中の武器ではなく職業レベル由来の火力(test.status.atk×倍率)にする

$scoreboard players set #mp_cost test.job.work $(mp_cost)

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
$scoreboard players set #multiplier test.job.work $(multiplier)
scoreboard players operation #damage test.physics_damage *= #multiplier test.job.work
scoreboard players operation #damage test.physics_damage /= #100 test.constant

scoreboard players set #damage test.def.pene 0
scoreboard players operation #damage test.def.pene = @s test.def.pene
scoreboard players set #damage test.physics_resist.pene 0
scoreboard players operation #damage test.physics_resist.pene = @s test.physics_resist.pene

scoreboard players operation #damage test.status.crit_rate = @s test.status.crit_rate
scoreboard players operation #damage test.status.crit_damage = @s test.status.crit_damage
scoreboard players operation #damage test.status.crit_damage /= #100 test.constant

tellraw @a ["",{selector:"@s"},{text:" のスキル！",color:gold}]

tag @s add damage_attacker
execute as @e[tag=battle_member,tag=enemy,distance=..64,scores={test.status.hp=1..}] run function test:battle/action/job_skill/hit_one
tag @s remove damage_attacker

function test:battle/turn_end
