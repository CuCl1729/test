#> test:mine/token/roll_loop
# #token_count 回、原石のレア度を1つずつ抽選する(mine_work.mine = 鉱脈の定義)

execute if score #token_count test.temporary matches ..0 run return 0
scoreboard players remove #token_count test.temporary 1
function test:mine/token/roll with storage test: mine_work.mine
function test:mine/token/roll_loop
