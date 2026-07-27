#> test:status/downed_tick
# @s = ダウン状態のプレイヤー

execute unless score @s test.status.hp matches ..0 run function test:status/downed_end_revived
execute if score @s test.status.hp matches ..0 run scoreboard players remove @s test.status.downed_timer 1
execute if score @s test.status.hp matches ..0 if score @s test.status.downed_timer matches ..0 run function test:status/downed_end_timeout