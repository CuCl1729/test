
scoreboard players operation @s test.temporary = @s test.multi_shot
scoreboard players add @s test.temporary 1

scoreboard players operation #angle test.temporary = #12000 test.constant
scoreboard players operation #angle test.temporary /= @s test.temporary

scoreboard players reset @s test.repeat

execute store result storage math: in int 0.01 run scoreboard players get #angle test.temporary

function #math:tan

execute store result score #dummy test.temporary run data get storage math: out 100

scoreboard players remove @s test.temporary 2
scoreboard players operation @s test.temporary *= #5 test.constant

execute store result storage test: teleport float -0.001 run scoreboard players operation #dummy test.temporary *= @s test.temporary

function test:projectile/pre_summon with storage test:

