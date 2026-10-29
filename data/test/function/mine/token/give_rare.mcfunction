#> test:mine/token/give_rare
# @s = プレイヤー。@macro rare: レア度。#ore_r<レア度> 個の原石(種類は mine_work.give.id)を渡す

$data modify storage test: mine_work.give.rare set value $(rare)
$execute store result storage test: mine_work.give.count int 1 run scoreboard players get #ore_r$(rare) test.temporary
function test:item/ore/give with storage test: mine_work.give
