#> test:ui/status/give_book
# @s = ステータスの本を受け取りたいプレイヤー

data remove storage test: loot.stat
execute store result storage test: loot.stat.level int 1 run scoreboard players get @s test.status.level
execute store result storage test: loot.stat.exp int 1 run scoreboard players get @s test.status.exp
execute store result storage test: loot.stat.skill_point int 1 run scoreboard players get @s test.status.skill_point
execute store result storage test: loot.stat.hp int 1 run scoreboard players get @s test.status.hp
execute store result storage test: loot.stat.hp_max int 1 run scoreboard players get @s test.status.hp_max
execute store result storage test: loot.stat.mp int 1 run scoreboard players get @s test.status.mp
execute store result storage test: loot.stat.mp_max int 1 run scoreboard players get @s test.status.mp_max
execute store result storage test: loot.stat.atk int 1 run scoreboard players get @s test.status.atk
execute store result storage test: loot.stat.def int 1 run scoreboard players get @s test.status.def
execute store result storage test: loot.stat.crit_rate int 1 run scoreboard players get @s test.status.crit_rate
execute store result storage test: loot.stat.crit_damage int 1 run scoreboard players get @s test.status.crit_damage

function test:ui/status/build_book with storage test: loot.stat
