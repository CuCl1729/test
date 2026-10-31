#> test:crop/token/row_loop
# @s = プレイヤー。crop_work.drops を1行ずつ渡す

execute unless data storage test: crop_work.drops[0] run return 0
function test:crop/token/give with storage test: crop_work.drops[0]
data remove storage test: crop_work.drops[0]
function test:crop/token/row_loop
