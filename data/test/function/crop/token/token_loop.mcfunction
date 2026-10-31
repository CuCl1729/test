#> test:crop/token/token_loop
# @s = プレイヤー。#crop_n 回、目印1個ぶんの行を全部抽選する

execute if score #crop_n test.temporary matches ..0 run return 0
scoreboard players remove #crop_n test.temporary 1
data modify storage test: crop_work.drops set from storage test: crop_work.drops_def
function test:crop/token/row_loop
function test:crop/token/token_loop
