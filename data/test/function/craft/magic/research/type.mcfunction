#> test:craft/magic/research/type
# @s = 研究するプレイヤー
# @macro type: 習得したい魔法タイプ (projectile|self)

scoreboard players set #newly_learned test.temporary 0
$execute unless score @s test.magic.known.$(type) matches 1 run scoreboard players set #newly_learned test.temporary 1

execute if score #newly_learned test.temporary matches 1 run scoreboard players remove @s test.status.skill_point 1
$execute if score #newly_learned test.temporary matches 1 run scoreboard players set @s test.magic.known.$(type) 1
$execute if score #newly_learned test.temporary matches 1 run tellraw @s [{text:"魔法要素「",color:gold},{text:"$(type)",color:aqua},{text:"」を習得した！",color:gold}]
$execute if score #newly_learned test.temporary matches 0 run tellraw @s [{text:"魔法要素「",color:gray},{text:"$(type)",color:aqua},{text:"」はすでに習得済みです",color:gray}]
