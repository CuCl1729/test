execute if entity @s[tag=block_X] run say block_x
execute if entity @s[tag=block_Y] run say block_y
execute if entity @s[tag=block_Z] run say block_z

execute if entity @s[tag=block_X] store result score @s test.temporary run data get entity @s Rotation[0] 100
execute if entity @s[tag=block_X] store result entity @s Rotation[0] float -0.01 run scoreboard players get @s test.temporary

execute if entity @s[tag=block_Y] store result score @s test.temporary run data get entity @s Rotation[1] 100
execute if entity @s[tag=block_Y] store result entity @s Rotation[1] float -0.01 run scoreboard players get @s test.temporary

execute if entity @s[tag=block_Z] store result score @s test.temporary run data get entity @s Rotation[0] 100
execute if entity @s[tag=block_Z] if score @s test.temporary matches 0.. run scoreboard players operation @s test.temporary += #18000 test.constant
execute if entity @s[tag=block_Z] if score @s test.temporary matches ..-1 run scoreboard players operation @s test.temporary -= #18000 test.constant
execute if entity @s[tag=block_Z] store result entity @s Rotation[0] float -0.01 run scoreboard players get @s test.temporary
