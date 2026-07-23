function test:class/cast {"class":"projectile"}

execute if entity @s[tag=projectile] run scoreboard players set @s test.boolean 1

function test:projectile/move