#> test:battle/action/skill_cast/projectile_resolve
# @s = 詠唱者。@e[tag=battle_target] = 決定済みの対象(1体)。選択した要素で魔法ダメージを与える

function #oh_my_dat:please
function test:battle/action/skill_cast/build

scoreboard players set #skill_sufficient test.temporary 0
execute if score @s test.status.mp >= #skill_cost test.temporary run scoreboard players set #skill_sufficient test.temporary 1

execute if score #skill_sufficient test.temporary matches 0 run tellraw @s [{text:"MPが足りません",color:gray}]
execute unless entity @e[tag=battle_target] run scoreboard players set #skill_sufficient test.temporary 0

execute if score #skill_sufficient test.temporary matches 1 run scoreboard players operation @s test.status.mp -= #skill_cost test.temporary

execute if score #skill_sufficient test.temporary matches 1 run function test:battle/action/skill_cast/prepare_damage

# 対象ごとにダメージ計算とメッセージ表示を行う(詠唱者は一時タグで参照する)
tag @s add battle_caster
execute if score #skill_sufficient test.temporary matches 1 as @e[tag=battle_target] run function test:battle/action/skill_cast/magic_hit
tag @e remove battle_caster

tag @e remove battle_target

function test:battle/turn_end
