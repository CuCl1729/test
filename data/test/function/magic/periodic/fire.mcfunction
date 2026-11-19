#> test:magic/periodic/fire
# @s = 一定間隔の発生源(at @s)。残り回数を1つ減らし、組み合わせの表が選んだ発生のしかたを呼ぶ。
# 回数は有限なので、無料で始まる段が無限に増えることはない
scoreboard players remove @s test.periodic.count 1
function test:magic/periodic/fire_entry with entity @s data.periodic
execute if score @s test.periodic.count matches ..0 run function test:magic/periodic/exhausted
