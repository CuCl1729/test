#> test:factory/go_try
# @s = 工場の区画へ行こうとしているプレイヤー(tag=factory_going)。区画ができていれば(test:factory/ensure_built)、
# 区画の真ん中の床の上へ移してタグを外す。まだなら何もしない(test:tick が次のtick以降にまた呼ぶ)

data modify storage test: factory_work.plot_arg set value {n:0}
execute store result storage test: factory_work.plot_arg.n int 1 run scoreboard players get @s test.factory.plot
function test:factory/plot_area with storage test: factory_work.plot_arg
scoreboard players set #fg_ok test.temporary 0
execute store result score #fg_ok test.temporary run function test:factory/ensure_built with storage test: factory_work.plot
execute if score #fg_ok test.temporary matches 0 run return 0

function test:factory/go_tp with storage test: factory_work.plot
tag @s remove factory_going
