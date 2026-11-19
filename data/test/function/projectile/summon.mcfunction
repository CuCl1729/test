execute unless function test:magic/root/can_spawn run return 0
execute unless function test:magic/root/commit run return 0

scoreboard players add @s test.repeat 1

summon armor_stand ^ ^ ^1 {Tags:[projectile,summoned,time],attributes:[{base:0,id:scale}]}

execute unless data storage test: status{radial:1b} unless data storage test: status{exact_origin:1b} as @n[tag=summoned] at @s facing entity @a[tag=shot_caster,limit=1] feet facing ^ ^ ^-1 run teleport @s ~ ~1.75 ~ ~ ~
execute if data storage test: status{radial:1b} unless data storage test: status{exact_origin:1b} run teleport @n[tag=summoned] ~ ~1.75 ~ ~ ~
# 確定ビームの待ち行列から起きた弾は、実行位置・向きのまま(高さ上げなし)
execute if data storage test: status{exact_origin:1b} run teleport @n[tag=summoned] ~ ~ ~ ~ ~

execute as @n[tag=summoned] run data modify entity @s Tags append from storage test: status.Tags[]
execute as @n[tag=summoned] run data modify entity @s data set from storage test: status.data

# 追尾があれば出た瞬間に相手を1回だけ選び、発射時刻を覚える(あとで delay_ticks と比べる)
execute if data entity @n[tag=summoned] data.homing store result score @n[tag=summoned] test.homing.launch run time query gametime
execute if data entity @n[tag=summoned] data.homing as @n[tag=summoned] at @s run function test:magic/homing/acquire with entity @s data.homing

execute store result score @n[tag=summoned] test.range run data get storage test: status.range
execute store result score @n[tag=summoned] test.gravity run data get storage test: status.gravity
execute store result score @n[tag=summoned] test.speed run data get storage test: status.speed

# 範囲タイプと組み合わせた投射体は、着弾時にこの半径で円状に効果を出す(0なら従来通り単体命中)
scoreboard players set @n[tag=summoned] test.aoe_radius 0
execute store result score @n[tag=summoned] test.aoe_radius run data get storage test: status.aoe_radius

# 一定間隔のつなぎが続く弾は、残り回数と次の起動までの tick を持つ(test:projectile/move が見る)
scoreboard players set @n[tag=summoned] test.periodic.count 0
scoreboard players set @n[tag=summoned] test.device.timer 0
execute store result score @n[tag=summoned] test.periodic.count run data get storage test: status.data.periodic.count
execute store result score @n[tag=summoned] test.device.timer run data get storage test: status.data.periodic.interval_ticks

# ダメージ表示で詠唱者を引けるよう、詠唱者のOhMyDatIDを覚えさせる
# (magic/.mcfunctionが詠唱の度に#oh_my_dat:pleaseを呼ぶため、この時点で必ず割り当て済み)
scoreboard players operation @n[tag=summoned] test.owner = @s OhMyDatID

scoreboard players operation @n[tag=summoned] test.fire_damage = @s test.fire_damage
scoreboard players operation @n[tag=summoned] test.water_damage = @s test.water_damage
scoreboard players operation @n[tag=summoned] test.wood_damage = @s test.wood_damage
scoreboard players operation @n[tag=summoned] test.metal_damage = @s test.metal_damage
scoreboard players operation @n[tag=summoned] test.earth_damage = @s test.earth_damage
scoreboard players operation @n[tag=summoned] test.physics_damage = @s test.physics_damage

scoreboard players operation @n[tag=summoned] test.fire_resist.pene = @s test.fire_resist.pene
scoreboard players operation @n[tag=summoned] test.water_resist.pene = @s test.water_resist.pene
scoreboard players operation @n[tag=summoned] test.wood_resist.pene = @s test.wood_resist.pene
scoreboard players operation @n[tag=summoned] test.metal_resist.pene = @s test.metal_resist.pene
scoreboard players operation @n[tag=summoned] test.earth_resist.pene = @s test.earth_resist.pene
scoreboard players operation @n[tag=summoned] test.physics_resist.pene = @s test.physics_resist.pene

scoreboard players operation @n[tag=summoned] test.def.pene = @s test.def.pene

execute if data storage test: magic.player.root as @n[tag=summoned] run function test:magic/root/retain with storage test: magic.player.root
tag @n[tag=summoned] remove summoned

$execute unless data storage test: status{radial:1b} if score @s test.repeat < @s test.multi_shot positioned ^$(out) ^ ^ run function test:projectile/summon with storage test: