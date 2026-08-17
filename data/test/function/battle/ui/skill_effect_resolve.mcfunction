#> test:battle/ui/skill_effect_resolve
# @s = 効果選択(トグル/決定)を行ったプレイヤー(チャット式)

scoreboard players operation #skill_effect test.battle.skill_effect = @s test.battle.skill_effect
scoreboard players set @s test.battle.skill_effect 0

# 加算してmaxで割った余りを取ることで循環させる(fire/heal/gravityは0↔1、威力上昇は0〜3)
scoreboard players set #toggle_max test.temporary 2
execute if score #skill_effect test.battle.skill_effect matches 1 run scoreboard players add @s test.magic.select.fire 1
execute if score #skill_effect test.battle.skill_effect matches 1 run scoreboard players operation @s test.magic.select.fire %= #toggle_max test.temporary

scoreboard players set #toggle_max test.temporary 4
execute if score #skill_effect test.battle.skill_effect matches 2 run scoreboard players add @s test.magic.select.atk 1
execute if score #skill_effect test.battle.skill_effect matches 2 run scoreboard players operation @s test.magic.select.atk %= #toggle_max test.temporary

scoreboard players set #toggle_max test.temporary 2
execute if score #skill_effect test.battle.skill_effect matches 3 run scoreboard players add @s test.magic.select.heal 1
execute if score #skill_effect test.battle.skill_effect matches 3 run scoreboard players operation @s test.magic.select.heal %= #toggle_max test.temporary

scoreboard players set #toggle_max test.temporary 2
execute if score #skill_effect test.battle.skill_effect matches 4 run scoreboard players add @s test.magic.select.gravity 1
execute if score #skill_effect test.battle.skill_effect matches 4 run scoreboard players operation @s test.magic.select.gravity %= #toggle_max test.temporary

# トリガーは一度使うと自動的に無効化されるため、決定以外は次のクリックのために再度enableする
execute if score #skill_effect test.battle.skill_effect matches 1..4 run scoreboard players enable @s test.battle.skill_effect
execute if score #skill_effect test.battle.skill_effect matches 1..4 run function test:battle/ui/skill_effect_display
execute if score #skill_effect test.battle.skill_effect matches 5 run function test:battle/ui/skill_effect_cast
