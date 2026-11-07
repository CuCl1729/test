#> test:money/pay_change
# @s = プレイヤー。コインだけで払えた。差額(#pc − #pn)をお釣りとしてコインで返す

scoreboard players operation #pc test.temporary -= #pn test.temporary
execute if score #pc test.temporary matches ..0 run return 1
execute store result storage test: money_work.n int 1 run scoreboard players get #pc test.temporary
function test:money/give_coins with storage test: money_work
return 1
