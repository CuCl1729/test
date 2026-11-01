#> test:npc/cart/act/withdraw_all
# @s = [全部引き出す] を取ったプレイヤー。口座の残高を全部コインで渡す

scoreboard players add @s test.money 0
execute if score @s test.money matches ..0 run return run tellraw @s {text:"残高が無い",color:"gray"}
execute store result storage test: money_work.n int 1 run scoreboard players get @s test.money
function test:npc/cart/act/withdraw with storage test: money_work
