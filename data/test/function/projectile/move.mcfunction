execute if score @s test.time = @s test.range run function test:projectile/kill

scoreboard players operation #damage test.fire_damage = @s test.fire_damage
scoreboard players operation #damage test.water_damage = @s test.water_damage
scoreboard players operation #damage test.wood_damage = @s test.wood_damage
scoreboard players operation #damage test.metal_damage = @s test.metal_damage
scoreboard players operation #damage test.earth_damage = @s test.earth_damage
scoreboard players operation #damage test.physics_damage = @s test.physics_damage

scoreboard players operation #damage test.status.crit_rate = @s test.status.crit_rate
scoreboard players operation #damage test.status.crit_damage = @s test.status.crit_damage
scoreboard players operation #damage test.def.pene = @s test.def.pene

execute store result score @s test.X0 run data get entity @s Pos[0] 100
execute store result score @s test.Y0 run data get entity @s Pos[1] 100
execute store result score @s test.Z0 run data get entity @s Pos[2] 100

execute if score @s test.X1 matches -2147483648..2147483647 run scoreboard players operation @s test.X1 -= @s test.X0
execute if score @s test.Y1 matches -2147483648..2147483647 run scoreboard players operation @s test.Y1 -= @s test.Y0
execute if score @s test.Z1 matches -2147483648..2147483647 run scoreboard players operation @s test.Z1 -= @s test.Z0

execute unless score @s test.X1 matches -2147483648..2147483647 run scoreboard players set @s test.X1 0
execute unless score @s test.Y1 matches -2147483648..2147483647 run scoreboard players set @s test.Y1 0
execute unless score @s test.Z1 matches -2147483648..2147483647 run scoreboard players set @s test.Z1 0

execute unless score @s test.X1 matches -10..10 run tag @s add block_X
execute unless score @s test.Y1 matches -10..10 run tag @s add block_Y
execute unless score @s test.Z1 matches -10..10 run tag @s add block_Z

execute unless score @s test.X1 matches -10..10 run tag @s add block
execute unless score @s test.Y1 matches -10..10 run tag @s add block
execute unless score @s test.Z1 matches -10..10 run tag @s add block

scoreboard players operation @s test.X0 *= @s test.speed
scoreboard players operation @s test.Y0 *= @s test.speed
scoreboard players operation @s test.Z0 *= @s test.speed

scoreboard players operation @s test.X0 /= #100 test.constant
scoreboard players operation @s test.Y0 /= #100 test.constant
scoreboard players operation @s test.Z0 /= #100 test.constant

execute if entity @s[tag=block] run function test:projectile/reflect

execute at @s run summon area_effect_cloud ^ ^ ^1.0 {Tags:[mark],Radius:0,WaitTime:0}

execute if entity @s[tag=gravity] run function test:projectile/gravity

execute store result score @s test.X1 run data get entity @n[tag=mark] Pos[0] 100
execute store result score @s test.Y1 run data get entity @n[tag=mark] Pos[1] 100
execute store result score @s test.Z1 run data get entity @n[tag=mark] Pos[2] 100

scoreboard players operation @s test.X1 *= @s test.speed
scoreboard players operation @s test.Y1 *= @s test.speed
scoreboard players operation @s test.Z1 *= @s test.speed

scoreboard players operation @s test.X1 /= #100 test.constant
scoreboard players operation @s test.Y1 /= #100 test.constant
scoreboard players operation @s test.Z1 /= #100 test.constant

execute if entity @s[tag=block_X] run scoreboard players set @s test.gravity_time 0

scoreboard players operation @s test.X0 -= @s test.X1
scoreboard players operation @s test.Y0 -= @s test.Y1
scoreboard players operation @s test.Z0 -= @s test.Z1

execute store result entity @s Motion[0] double -0.01 run scoreboard players get @s test.X0
execute store result entity @s Motion[1] double -0.01 run scoreboard players get @s test.Y0
execute store result entity @s Motion[2] double -0.01 run scoreboard players get @s test.Z0

scoreboard players operation @s test.X1 += @s test.X0
scoreboard players operation @s test.Y1 += @s test.Y0
scoreboard players operation @s test.Z1 += @s test.Z0

scoreboard players operation @s test.X1 *= #100 test.constant
scoreboard players operation @s test.Y1 *= #100 test.constant
scoreboard players operation @s test.Z1 *= #100 test.constant

scoreboard players operation @s test.X1 /= @s test.speed
scoreboard players operation @s test.Y1 /= @s test.speed
scoreboard players operation @s test.Z1 /= @s test.speed

scoreboard players operation @s test.X1 -= @s test.X0
scoreboard players operation @s test.Y1 -= @s test.Y0
scoreboard players operation @s test.Z1 -= @s test.Z0

tag @s remove block
tag @s remove block_X
tag @s remove block_Y
tag @s remove block_Z

kill @n[tag=mark]

execute at @s run particle end_rod ~ ~ ~ 0 0 0 0 0

execute as @e[tag=!projectile,dx=-0.25,dy=-0.25,dz=-0.25] positioned ~-1 ~-1 ~-1 if entity @s[dx=0.25,dy=0.25,dz=0.25] run function test:magic/hit
