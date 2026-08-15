#> test:battle/enemy_delay_tick
# @s = 戦闘マーカー。敵の行動までの間を1tickずつ減らし、0になったら実際に行動させる

scoreboard players remove @s test.battle.enemy_delay 1

execute if score @s test.battle.enemy_delay matches 0 run function test:battle/enemy_delay_resolve
