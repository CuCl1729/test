#> test:debug/reset_battle_state
# @s = 戦闘状態をリセットしたい対象(プレイヤー・敵どちらでも)

scoreboard players set @s test.battle.id 0
scoreboard players set @s test.battle.turn_order 0
scoreboard players set @s test.battle.arena 0
tag @s remove battle_member

execute if score @s test.status.hp matches ..0 run scoreboard players operation @s test.status.hp = @s test.status.hp_max

tag @s remove downed
scoreboard players set @s test.status.downed_timer 0
effect clear @s minecraft:blindness
effect clear @s minecraft:slowness
effect clear @s minecraft:weakness