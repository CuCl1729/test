#> test:factory/assign
# @s = プレイヤー。工場の区画がまだ無ければ、次の番号を割り当てる(test.factory.plot。1から)。一度割り当てた番号は変えない

execute if score @s test.factory.plot matches 1.. run return 0
scoreboard players add #factory_next test.factory.plot 1
scoreboard players operation @s test.factory.plot = #factory_next test.factory.plot
