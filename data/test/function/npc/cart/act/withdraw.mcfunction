#> test:npc/cart/act/withdraw
# @s = 引き出すボタンを取ったプレイヤー。@macro n: 金額。口座の残高が足りれば引いてコインで渡し、足りなければ何もせずに「足りない」と出す

scoreboard players add @s test.money 0
$execute unless score @s test.money matches $(n).. run return run tellraw @s {text:"残高が足りない",color:"red"}
$scoreboard players remove @s test.money $(n)
$scoreboard players set #md test.temporary -$(n)
function test:money/show
$function test:money/give_coins {n:$(n)}
