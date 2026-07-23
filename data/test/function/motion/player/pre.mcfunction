execute positioned 0.0 0.0 0.0 run summon marker ^1 ^ ^ {Tags:[x]}

execute store result score #temporary test.X0 run data get entity @n[tag=x] Pos[0] 1000
execute store result score #temporary test.Y0 run data get entity @n[tag=x] Pos[1] 1000
execute store result score #temporary test.Z0 run data get entity @n[tag=x] Pos[2] 1000

scoreboard players operation #motion test.temporary = #motion test.X0
scoreboard players operation #motion test.temporary *= #temporary test.X0
scoreboard players operation #motion test.temporary /= #1000 test.constant
scoreboard players operation #motion test.X1 = #motion test.temporary

scoreboard players operation #motion test.temporary = #motion test.Y0
scoreboard players operation #motion test.temporary *= #temporary test.Y0
scoreboard players operation #motion test.temporary /= #1000 test.constant
scoreboard players operation #motion test.X1 += #motion test.temporary

scoreboard players operation #motion test.temporary = #motion test.Z0
scoreboard players operation #motion test.temporary *= #temporary test.Z0
scoreboard players operation #motion test.temporary /= #1000 test.constant
scoreboard players operation #motion test.X1 += #motion test.temporary

execute positioned 0.0 0.0 0.0 run summon marker ^ ^1 ^ {Tags:[y]}

execute store result score #temporary test.X0 run data get entity @n[tag=y] Pos[0] 1000
execute store result score #temporary test.Y0 run data get entity @n[tag=y] Pos[1] 1000
execute store result score #temporary test.Z0 run data get entity @n[tag=y] Pos[2] 1000

scoreboard players operation #motion test.temporary = #motion test.X0
scoreboard players operation #motion test.temporary *= #temporary test.X0
scoreboard players operation #motion test.temporary /= #1000 test.constant
scoreboard players operation #motion test.Y1 = #motion test.temporary

scoreboard players operation #motion test.temporary = #motion test.Y0
scoreboard players operation #motion test.temporary *= #temporary test.Y0
scoreboard players operation #motion test.temporary /= #1000 test.constant
scoreboard players operation #motion test.Y1 += #motion test.temporary

scoreboard players operation #motion test.temporary = #motion test.Z0
scoreboard players operation #motion test.temporary *= #temporary test.Z0
scoreboard players operation #motion test.temporary /= #1000 test.constant
scoreboard players operation #motion test.Y1 += #motion test.temporary

execute positioned 0.0 0.0 0.0 run summon marker ^ ^ ^1 {Tags:[z]}

execute store result score #temporary test.X0 run data get entity @n[tag=z] Pos[0] 1000
execute store result score #temporary test.Y0 run data get entity @n[tag=z] Pos[1] 1000
execute store result score #temporary test.Z0 run data get entity @n[tag=z] Pos[2] 1000

scoreboard players operation #motion test.temporary = #motion test.X0
scoreboard players operation #motion test.temporary *= #temporary test.X0
scoreboard players operation #motion test.temporary /= #1000 test.constant
scoreboard players operation #motion test.Z1 = #motion test.temporary

scoreboard players operation #motion test.temporary = #motion test.Y0
scoreboard players operation #motion test.temporary *= #temporary test.Y0
scoreboard players operation #motion test.temporary /= #1000 test.constant
scoreboard players operation #motion test.Z1 += #motion test.temporary

scoreboard players operation #motion test.temporary = #motion test.Z0
scoreboard players operation #motion test.temporary *= #temporary test.Z0
scoreboard players operation #motion test.temporary /= #1000 test.constant
scoreboard players operation #motion test.Z1 += #motion test.temporary

kill @n[tag=x]
kill @n[tag=y]
kill @n[tag=z]