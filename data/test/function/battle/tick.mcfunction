#> test:battle/tick
# @s = 戦闘マーカー

execute unless score @s test.battle.acting matches 1 run function test:battle/turn_start
execute if score @s test.battle.acting matches 1 if score @s test.battle.awaiting_skill matches 1 run function test:battle/ui/skill_poll
execute if score @s test.battle.acting matches 1 unless score @s test.battle.awaiting_skill matches 1 if score @s test.battle.enemy_delay matches 1.. run function test:battle/enemy_delay_tick
execute if score @s test.battle.acting matches 1 unless score @s test.battle.awaiting_skill matches 1 unless score @s test.battle.enemy_delay matches 1.. run function test:battle/ui/chat_poll
