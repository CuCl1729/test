#> test:battle/action/skill_cast/self
# @s = 詠唱者。習得済みの要素(自己 + 判明している効果/ステータス)をそのまま自分に唱える

data remove storage test: magic.player
data modify storage test: magic.player.magic_type set value "self"

scoreboard players set #skill_cost test.temporary 20

execute if score @s test.magic.known.fire matches 1 if score @s test.magic.select.fire matches 1 run data modify storage test: magic.player.data.magic.fire.base set value 1000
execute if score @s test.magic.known.fire matches 1 if score @s test.magic.select.fire matches 1 run scoreboard players add #skill_cost test.temporary 50

# 威力上昇は選んだ回数(0〜3)ぶん重ねがけされる
execute if score @s test.magic.known.atk matches 1 if score @s test.magic.select.atk matches 1.. run scoreboard players operation #atk_value test.temporary = @s test.magic.select.atk
execute if score @s test.magic.known.atk matches 1 if score @s test.magic.select.atk matches 1.. run scoreboard players operation #atk_value test.temporary *= #1000 test.constant
execute if score @s test.magic.known.atk matches 1 if score @s test.magic.select.atk matches 1.. run execute store result storage test: magic.player.data.magic.fire.atk int 1 run scoreboard players get #atk_value test.temporary
execute if score @s test.magic.known.atk matches 1 if score @s test.magic.select.atk matches 1.. run scoreboard players operation #atk_cost test.temporary = @s test.magic.select.atk
execute if score @s test.magic.known.atk matches 1 if score @s test.magic.select.atk matches 1.. run scoreboard players operation #atk_cost test.temporary *= #100 test.constant
execute if score @s test.magic.known.atk matches 1 if score @s test.magic.select.atk matches 1.. run scoreboard players operation #skill_cost test.temporary += #atk_cost test.temporary

execute if score @s test.magic.known.heal matches 1 if score @s test.magic.select.heal matches 1 run data modify storage test: magic.player.heal.power set value 3
execute if score @s test.magic.known.heal matches 1 if score @s test.magic.select.heal matches 1 run scoreboard players add #skill_cost test.temporary 200

execute store success score #skill_sufficient test.temporary if score @s test.status.mp >= #skill_cost test.temporary

execute if score #skill_sufficient test.temporary matches 0 run tellraw @s [{text:"MPが足りません",color:gray}]

execute if score #skill_sufficient test.temporary matches 1 run scoreboard players operation @s test.status.mp -= #skill_cost test.temporary
execute if score #skill_sufficient test.temporary matches 1 if data storage test: magic.player.heal run scoreboard players reset @s test.repeat
execute if score #skill_sufficient test.temporary matches 1 if data storage test: magic.player.heal run function test:magic/effect/heal
execute if score #skill_sufficient test.temporary matches 1 run tellraw @a ["",{selector:"@s"},{text:" は自分に魔法を唱えた！",color:light_purple}]

function test:battle/turn_end
