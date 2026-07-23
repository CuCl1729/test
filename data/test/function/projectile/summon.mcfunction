scoreboard players add @s test.repeat 1

summon armor_stand ^ ^ ^1 {Tags:[projectile,summoned,time],attributes:[{base:0,id:scale}]}

execute as @n[tag=summoned] at @s facing entity @n[type=player] feet facing ^ ^ ^-1 run teleport @s ~ ~1.75 ~ ~ ~

execute as @n[tag=summoned] run data modify entity @s Tags append from storage test: status.Tags[]
execute as @n[tag=summoned] run data modify entity @s data set from storage test: status.data

execute store result score @n[tag=summoned] test.range run data get storage test: status.range
execute store result score @n[tag=summoned] test.gravity run data get storage test: status.gravity
execute store result score @n[tag=summoned] test.speed run data get storage test: status.speed

scoreboard players operation @n[tag=summoned] test.fire_damage = @s test.fire_damage
scoreboard players operation @n[tag=summoned] test.water_damage = @s test.water_damage
scoreboard players operation @n[tag=summoned] test.wood_damage = @s test.wood_damage
scoreboard players operation @n[tag=summoned] test.metal_damage = @s test.metal_damage
scoreboard players operation @n[tag=summoned] test.earth_damage = @s test.earth_damage

scoreboard players operation @n[tag=summoned] test.fire_resist.pene = @s test.fire_resist.pene
scoreboard players operation @n[tag=summoned] test.water_resist.pene = @s test.water_resist.pene
scoreboard players operation @n[tag=summoned] test.wood_resist.pene = @s test.wood_resist.pene
scoreboard players operation @n[tag=summoned] test.metal_resist.pene = @s test.metal_resist.pene
scoreboard players operation @n[tag=summoned] test.earth_resist.pene = @s test.earth_resist.pene

scoreboard players operation @n[tag=summoned] test.def.pene = @s test.def.pene

tellraw @a {type:"nbt",source:"entity",nbt:"data",entity:"@n[tag=summoned]"}

tag @n[tag=summoned] remove summoned

$execute if score @s test.repeat < @s test.multi_shot positioned ^$(out) ^ ^ run function test:projectile/summon with storage math: