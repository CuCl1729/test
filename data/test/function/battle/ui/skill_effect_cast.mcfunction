#> test:battle/ui/skill_effect_cast
# @s = 詠唱を確定したプレイヤー。test.battle.skill_typeとtest.magic.select.*を元に唱える

scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.awaiting_skill 0

execute if score @s test.battle.skill_type matches 1 run function test:battle/action/skill_cast/self

# 投射魔法はアイテム式ならここに来る前(test:battle/ui/skill_effect_minecart_resolve)で対象決定済み。
# チャット式はここで対象が複数いれば選択させる
execute if score @s test.battle.skill_type matches 2 if score @s test.settings.battle_ui matches 1 run function test:battle/action/skill_cast/projectile
execute if score @s test.battle.skill_type matches 2 if score @s test.settings.battle_ui matches 2 run function test:battle/action/skill_cast/projectile_resolve
