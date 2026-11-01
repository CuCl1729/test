#> test:money/add
# @s = プレイヤー。@macro n: 口座に足す金額(0以上)。足したら残高をアクションバーに出す

scoreboard players add @s test.money 0
$scoreboard players add @s test.money $(n)
$scoreboard players set #md test.temporary $(n)
function test:money/show
