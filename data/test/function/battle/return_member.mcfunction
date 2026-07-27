#> test:battle/return_member

execute store result storage test: battle.temporary.x int 1 run scoreboard players get @s test.battle.return_x
execute store result storage test: battle.temporary.y int 1 run scoreboard players get @s test.battle.return_y
execute store result storage test: battle.temporary.z int 1 run scoreboard players get @s test.battle.return_z

scoreboard players set @s test.battle.id 0
tag @s remove battle_member

execute in test:turn run function test:battle/return_member_tp with storage test: battle.temporary