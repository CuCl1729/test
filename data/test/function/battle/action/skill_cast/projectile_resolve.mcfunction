#> test:battle/action/skill_cast/projectile_resolve
# @s = 詠唱者。@e[tag=battle_target] = 決定済みの対象(1体)。習得済みの要素で魔法ダメージを与える

data remove storage test: magic.player
data modify storage test: magic.player.magic_type set value "projectile"

scoreboard players set #skill_cost test.temporary 50

execute if score @s test.magic.known.fire matches 1 if score @s test.magic.select.fire matches 1 run data modify storage test: magic.player.data.magic.fire.base set value 1000
execute if score @s test.magic.known.fire matches 1 if score @s test.magic.select.fire matches 1 run scoreboard players add #skill_cost test.temporary 50

# 威力上昇は選んだ回数(0〜3)ぶん重ねがけされる
execute if score @s test.magic.known.atk matches 1 if score @s test.magic.select.atk matches 1.. run scoreboard players operation #atk_value test.temporary = @s test.magic.select.atk
execute if score @s test.magic.known.atk matches 1 if score @s test.magic.select.atk matches 1.. run scoreboard players operation #atk_value test.temporary *= #1000 test.constant
execute if score @s test.magic.known.atk matches 1 if score @s test.magic.select.atk matches 1.. run execute store result storage test: magic.player.data.magic.fire.atk int 1 run scoreboard players get #atk_value test.temporary
execute if score @s test.magic.known.atk matches 1 if score @s test.magic.select.atk matches 1.. run scoreboard players operation #atk_cost test.temporary = @s test.magic.select.atk
execute if score @s test.magic.known.atk matches 1 if score @s test.magic.select.atk matches 1.. run scoreboard players operation #atk_cost test.temporary *= #100 test.constant
execute if score @s test.magic.known.atk matches 1 if score @s test.magic.select.atk matches 1.. run scoreboard players operation #skill_cost test.temporary += #atk_cost test.temporary

execute if score @s test.magic.known.gravity matches 1 if score @s test.magic.select.gravity matches 1 run scoreboard players add #skill_cost test.temporary 10

execute store success score #skill_sufficient test.temporary if score @s test.status.mp >= #skill_cost test.temporary

execute if score #skill_sufficient test.temporary matches 0 run tellraw @s [{text:"MPが足りません",color:gray}]
execute unless entity @e[tag=battle_target] run scoreboard players set #skill_sufficient test.temporary 0

execute if score #skill_sufficient test.temporary matches 1 run scoreboard players operation @s test.status.mp -= #skill_cost test.temporary

execute if score #skill_sufficient test.temporary matches 1 run function test:damage/pre_magic

execute if score #skill_sufficient test.temporary matches 1 run scoreboard players set #damage test.physics_damage 0
execute if score #skill_sufficient test.temporary matches 1 run scoreboard players operation #damage test.fire_damage = @s test.fire_damage
execute if score #skill_sufficient test.temporary matches 1 run scoreboard players operation #damage test.water_damage = @s test.water_damage
execute if score #skill_sufficient test.temporary matches 1 run scoreboard players operation #damage test.wood_damage = @s test.wood_damage
execute if score #skill_sufficient test.temporary matches 1 run scoreboard players operation #damage test.metal_damage = @s test.metal_damage
execute if score #skill_sufficient test.temporary matches 1 run scoreboard players operation #damage test.earth_damage = @s test.earth_damage

execute if score #skill_sufficient test.temporary matches 1 run scoreboard players set #damage test.def.pene 0
execute if score #skill_sufficient test.temporary matches 1 run scoreboard players operation #damage test.def.pene = @s test.def.pene
execute if score #skill_sufficient test.temporary matches 1 run scoreboard players set #damage test.fire_resist.pene 0
execute if score #skill_sufficient test.temporary matches 1 run scoreboard players operation #damage test.fire_resist.pene = @s test.fire_resist.pene
execute if score #skill_sufficient test.temporary matches 1 run scoreboard players set #damage test.water_resist.pene 0
execute if score #skill_sufficient test.temporary matches 1 run scoreboard players operation #damage test.water_resist.pene = @s test.water_resist.pene
execute if score #skill_sufficient test.temporary matches 1 run scoreboard players set #damage test.wood_resist.pene 0
execute if score #skill_sufficient test.temporary matches 1 run scoreboard players operation #damage test.wood_resist.pene = @s test.wood_resist.pene
execute if score #skill_sufficient test.temporary matches 1 run scoreboard players set #damage test.metal_resist.pene 0
execute if score #skill_sufficient test.temporary matches 1 run scoreboard players operation #damage test.metal_resist.pene = @s test.metal_resist.pene
execute if score #skill_sufficient test.temporary matches 1 run scoreboard players set #damage test.earth_resist.pene 0
execute if score #skill_sufficient test.temporary matches 1 run scoreboard players operation #damage test.earth_resist.pene = @s test.earth_resist.pene

execute if score #skill_sufficient test.temporary matches 1 run scoreboard players operation #damage test.status.crit_rate = @s test.status.crit_rate
execute if score #skill_sufficient test.temporary matches 1 run scoreboard players operation #damage test.status.crit_damage = @s test.status.crit_damage
execute if score #skill_sufficient test.temporary matches 1 run scoreboard players operation #damage test.status.crit_damage /= #100 test.constant

execute if score #skill_sufficient test.temporary matches 1 as @e[tag=battle_target] run function test:damage/

execute if score #skill_sufficient test.temporary matches 1 run scoreboard players set #total_damage test.temporary 0
execute if score #skill_sufficient test.temporary matches 1 run scoreboard players operation #total_damage test.temporary += #victim test.fire_damage
execute if score #skill_sufficient test.temporary matches 1 run scoreboard players operation #total_damage test.temporary += #victim test.water_damage
execute if score #skill_sufficient test.temporary matches 1 run scoreboard players operation #total_damage test.temporary += #victim test.wood_damage
execute if score #skill_sufficient test.temporary matches 1 run scoreboard players operation #total_damage test.temporary += #victim test.metal_damage
execute if score #skill_sufficient test.temporary matches 1 run scoreboard players operation #total_damage test.temporary += #victim test.earth_damage
execute if score #skill_sufficient test.temporary matches 1 run scoreboard players operation #total_damage test.temporary /= #100 test.constant

execute if score #skill_sufficient test.temporary matches 1 run tellraw @a ["",{selector:"@s"},{text:" の魔法！ ",color:light_purple},{selector:"@e[tag=battle_target,limit=1]"},{text:" に",color:gray},{score:{name:"#total_damage",objective:"test.temporary"},color:light_purple},{text:"ダメージ！",color:gray}]

execute if entity @e[tag=battle_target,tag=enemy,scores={test.status.hp=..0}] run tellraw @a ["",{selector:"@e[tag=battle_target,tag=enemy,limit=1]"},{text:"を倒した！",color:gold}]

tag @e remove battle_target

function test:battle/turn_end
