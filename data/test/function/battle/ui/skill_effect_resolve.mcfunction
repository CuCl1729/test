#> test:battle/ui/skill_effect_resolve
# @s = 効果選択(トグル/決定)を行ったプレイヤー(チャット式)

scoreboard players operation #skill_effect test.battle.skill_effect = @s test.battle.skill_effect
scoreboard players set @s test.battle.skill_effect 0

# 元の値を先に控えてから判定する(1行目で0にした直後に2行目が「今0かどうか」を見てしまうと
# 即座に1へ戻ってしまい、有効から無効に切り替わらなくなるため)
scoreboard players operation #toggle_effect test.temporary = @s test.magic.select.fire
execute if score #skill_effect test.battle.skill_effect matches 1 if score #toggle_effect test.temporary matches 1 run scoreboard players set @s test.magic.select.fire 0
execute if score #skill_effect test.battle.skill_effect matches 1 if score #toggle_effect test.temporary matches 0 run scoreboard players set @s test.magic.select.fire 1

scoreboard players operation #toggle_effect test.temporary = @s test.magic.select.atk
execute if score #skill_effect test.battle.skill_effect matches 2 if score #toggle_effect test.temporary matches 1 run scoreboard players set @s test.magic.select.atk 0
execute if score #skill_effect test.battle.skill_effect matches 2 if score #toggle_effect test.temporary matches 0 run scoreboard players set @s test.magic.select.atk 1

scoreboard players operation #toggle_effect test.temporary = @s test.magic.select.heal
execute if score #skill_effect test.battle.skill_effect matches 3 if score #toggle_effect test.temporary matches 1 run scoreboard players set @s test.magic.select.heal 0
execute if score #skill_effect test.battle.skill_effect matches 3 if score #toggle_effect test.temporary matches 0 run scoreboard players set @s test.magic.select.heal 1

scoreboard players operation #toggle_effect test.temporary = @s test.magic.select.gravity
execute if score #skill_effect test.battle.skill_effect matches 4 if score #toggle_effect test.temporary matches 1 run scoreboard players set @s test.magic.select.gravity 0
execute if score #skill_effect test.battle.skill_effect matches 4 if score #toggle_effect test.temporary matches 0 run scoreboard players set @s test.magic.select.gravity 1

# トリガーは一度使うと自動的に無効化されるため、決定以外は次のクリックのために再度enableする
execute if score #skill_effect test.battle.skill_effect matches 1..4 run scoreboard players enable @s test.battle.skill_effect
execute if score #skill_effect test.battle.skill_effect matches 1..4 run function test:battle/ui/skill_effect_display
execute if score #skill_effect test.battle.skill_effect matches 5 run function test:battle/ui/skill_effect_cast
