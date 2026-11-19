#> test:action/weapon/pay
# @s = 武器の発動者。magic.player.cost(コンパイル済み装備から来た、反動や杖割引を含まない信頼済みの
# 非負整数。単位は従来の武器MP消費と同じ)を払う。MPが足りなければ何も払わずに fail、払えたら1を返す

scoreboard players set #weapon_mp_cost test.temporary 0
execute store result score #weapon_mp_cost test.temporary run data get storage test: magic.player.cost

execute if score @s test.status.mp < #weapon_mp_cost test.temporary run tellraw @s [{text:"MPが足りません",color:gray}]
execute if score @s test.status.mp < #weapon_mp_cost test.temporary run return 0

scoreboard players operation @s test.status.mp -= #weapon_mp_cost test.temporary
return 1
