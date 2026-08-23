#> test:battle/action/skill_cast/self
# @s = 詠唱者。選択した要素をそのまま自分に唱える

function #oh_my_dat:please
function test:battle/action/skill_cast/build

scoreboard players set #skill_sufficient test.temporary 0
execute if score @s test.status.mp >= #skill_cost test.temporary run scoreboard players set #skill_sufficient test.temporary 1

execute if score #skill_sufficient test.temporary matches 0 run tellraw @s [{text:"MPが足りません",color:gray}]

execute if score #skill_sufficient test.temporary matches 1 run scoreboard players operation @s test.status.mp -= #skill_cost test.temporary
execute if score #skill_sufficient test.temporary matches 1 if data storage test: magic.player.heal run scoreboard players reset @s test.repeat
execute if score #skill_sufficient test.temporary matches 1 if data storage test: magic.player.heal run function test:magic/effect/heal
execute if score #skill_sufficient test.temporary matches 1 run tellraw @a ["",{selector:"@s"},{text:" は自分に魔法を唱えた！",color:light_purple}]

function test:battle/turn_end
