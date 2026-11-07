scoreboard players operation @s test.status.hp = @s test.status.hp_max
tag @s remove downed

execute unless entity @e[tag=safe_area,distance=0..] run return run tellraw @s {text:"帰還先が見つからないため、その場で復帰しました",color:"gray"}
tp @s @e[tag=safe_area,distance=0..,sort=nearest,limit=1]