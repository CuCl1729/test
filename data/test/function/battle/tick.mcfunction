#> test:battle/tick
# @s = 戦闘マーカー

execute unless score @s test.battle.acting matches 1 run function test:battle/turn_start
execute if score @s test.battle.acting matches 1 run function test:battle/ui/chat_poll