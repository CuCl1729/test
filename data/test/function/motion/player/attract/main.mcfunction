
execute store result score #motion test.X1 run data get entity @s Pos[0] 100
execute store result score #motion test.Y1 run data get entity @s Pos[1] 100
execute store result score #motion test.Z1 run data get entity @s Pos[2] 100

scoreboard players operation #motion test.X0 = @s test.X0
scoreboard players operation #motion test.Y0 = @s test.Y0
scoreboard players operation #motion test.Z0 = @s test.Z0

scoreboard players operation #motion test.X0 -= #motion test.X1
scoreboard players operation #motion test.Y0 -= #motion test.Y1
scoreboard players operation #motion test.Z0 -= #motion test.Z1

scoreboard players operation #motion test.X0 /= #10 test.constant
scoreboard players operation #motion test.Y0 /= #100 test.constant
scoreboard players operation #motion test.Z0 /= #10 test.constant

scoreboard players operation #motion test.X0 /= #7 test.constant
scoreboard players operation #motion test.Y0 /= #2 test.constant
scoreboard players operation #motion test.Z0 /= #7 test.constant

execute if score #motion test.X0 matches -10..10 run scoreboard players set #motion test.X0 0
execute if score #motion test.Y0 matches -10..10 run scoreboard players set #motion test.Y0 0
execute if score #motion test.Z0 matches -10..10 run scoreboard players set #motion test.Z0 0

execute if score #motion test.X0 matches 0 run scoreboard players set #motion test.X0 1
execute if score #motion test.Y0 matches 0 run scoreboard players set #motion test.Y0 1
execute if score #motion test.Z0 matches 0 run scoreboard players set #motion test.Z0 1

scoreboard players operation #motion test.temporary = #motion test.X0
scoreboard players operation #motion test.temporary *= #motion test.Y0
scoreboard players operation #motion test.temporary *= #motion test.Z0
scoreboard players operation #motion test.temporary /= #power test.multiplier

execute if score #motion test.temporary matches -10..10 run tag @s remove attract

function test:motion/player/pre

item modify entity @s saddle test:move/add_impulse