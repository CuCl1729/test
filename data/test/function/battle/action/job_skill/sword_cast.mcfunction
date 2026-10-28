#> test:battle/action/job_skill/sword_cast
# @s = 詠唱者(手番)。装備中の武器(範囲攻撃剣)で、生存している敵全員へ範囲攻撃を当てる
# (ターン制には実際の位置関係が無いため対象選択を挟まない)。ダメージはリアルタイムの test:attack/aoe と同じく、
# 通常攻撃のダメージ(test:attack/prepare_damage)× aoe_multiplier。
# 武器は手番の開始時に控えた battle.actor_weapon.item から読む(アイテム式UIはメインハンドが行動アイテムのため)

data modify storage test: attack.player set value {}
data modify storage test: attack.player set from storage test: battle.actor_weapon.item
execute unless data storage test: attack.player.damage run data modify storage test: attack.player.damage set value {physics:{atk:100}}

scoreboard players set #mp_cost test.job.work 0
execute store result score #mp_cost test.job.work run data get storage test: attack.player.weapon[{type:"aoe_mp_cost"}].value

scoreboard players set #skill_sufficient test.temporary 0
execute if score @s test.status.mp >= #mp_cost test.job.work run scoreboard players set #skill_sufficient test.temporary 1

execute if score #skill_sufficient test.temporary matches 0 run tellraw @s [{text:"MPが足りません",color:gray}]
execute if score #skill_sufficient test.temporary matches 0 run return run function test:battle/turn_end

scoreboard players operation @s test.status.mp -= #mp_cost test.job.work

function test:attack/prepare_damage

scoreboard players set #multiplier test.job.work 0
execute store result score #multiplier test.job.work run data get storage test: attack.player.weapon[{type:"aoe_multiplier"}].value
scoreboard players operation #damage test.fire_damage *= #multiplier test.job.work
scoreboard players operation #damage test.fire_damage /= #100 test.constant
scoreboard players operation #damage test.water_damage *= #multiplier test.job.work
scoreboard players operation #damage test.water_damage /= #100 test.constant
scoreboard players operation #damage test.wood_damage *= #multiplier test.job.work
scoreboard players operation #damage test.wood_damage /= #100 test.constant
scoreboard players operation #damage test.metal_damage *= #multiplier test.job.work
scoreboard players operation #damage test.metal_damage /= #100 test.constant
scoreboard players operation #damage test.earth_damage *= #multiplier test.job.work
scoreboard players operation #damage test.earth_damage /= #100 test.constant
scoreboard players operation #damage test.physics_damage *= #multiplier test.job.work
scoreboard players operation #damage test.physics_damage /= #100 test.constant

tellraw @a[distance=..64] ["",{selector:"@s"},{text:" の範囲攻撃！",color:aqua}]

# damage_attacker はダメージ表示用、battle_attacker は命中時の効果(test:battle/action/attack_hit_buff)用
tag @s add damage_attacker
tag @s add battle_attacker
execute as @e[tag=battle_member,tag=enemy,distance=..64,scores={test.status.hp=1..}] run function test:battle/action/job_skill/hit_one
tag @s remove damage_attacker
tag @s remove battle_attacker

function test:battle/turn_end
