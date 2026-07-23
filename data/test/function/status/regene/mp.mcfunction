scoreboard players operation @s test.status.mp += @s test.status.mp_regene

execute if score @s test.status.mp > @s test.status.mp_max run scoreboard players operation @s test.status.mp = @s test.status.mp_max
