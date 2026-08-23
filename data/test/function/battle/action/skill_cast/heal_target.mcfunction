#> test:battle/action/skill_cast/heal_target
# @s = 回復する対象。magic/effect/healは@sのHPを増やす再帰関数なので、呼ぶ前後の差から
# 実際の回復量を求めて表示する(HPは内部で100倍値なので、表示時は100で割る)

scoreboard players operation #heal_before test.temporary = @s test.status.hp

scoreboard players reset @s test.repeat
function test:magic/effect/heal

scoreboard players operation #heal_amount test.temporary = @s test.status.hp
scoreboard players operation #heal_amount test.temporary -= #heal_before test.temporary
scoreboard players operation #heal_amount test.temporary /= #100 test.constant

execute if score #heal_amount test.temporary matches 1.. run tellraw @a ["",{selector:"@s"},{text:" は",color:gray},{score:{name:"#heal_amount",objective:"test.temporary"},color:green},{text:"回復した！",color:gray}]
