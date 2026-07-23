scoreboard players operation @s test.status.hp += @s test.status.hp_regene

execute if score @s test.status.hp > @s test.status.hp_max run scoreboard players operation @s test.status.hp = @s test.status.hp_max
