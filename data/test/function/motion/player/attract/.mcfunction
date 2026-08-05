tag @s add attract

execute store result score #motion test.X1 run data get entity @s Pos[0] 100
execute store result score #motion test.Y1 run data get entity @s Pos[1] 100
execute store result score #motion test.Z1 run data get entity @s Pos[2] 100

scoreboard players operation #motion test.X0 = @s test.X0
scoreboard players operation #motion test.Y0 = @s test.Y0
scoreboard players operation #motion test.Z0 = @s test.Z0

scoreboard players operation #motion test.X0 -= #motion test.X1
scoreboard players operation #motion test.Y0 -= #motion test.Y1
scoreboard players operation #motion test.Z0 -= #motion test.Z1

scoreboard players operation #motion test.X0 /= #100 test.constant
scoreboard players operation #motion test.Y0 /= #100 test.constant
scoreboard players operation #motion test.Z0 /= #100 test.constant

function test:motion/player/pre

item modify entity @s saddle test:move/add_impulse