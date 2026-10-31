#> test:fish/token/roll_loop
# @s = プレイヤー。#fish_n 回、素材を1つ選んで渡す

execute if score #fish_n test.temporary matches ..0 run return 0
scoreboard players remove #fish_n test.temporary 1
function test:fish/token/roll with storage test: fish_work.pool
function test:fish/token/roll_loop
