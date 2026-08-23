#> test:magic/crafter/status
# @s = クラフター本体。@macro status: 素材が示す魔法ステータス強化id

execute as @p[distance=..6] run function #oh_my_dat:please
$execute as @p[distance=..6] run function test:magic/registry/known_check {id:"$(status)"}

$execute if score #known test.temporary matches 1 run function test:asset/magic/status/$(status)
