#> test:magic/crafter/effect
# @s = クラフター本体。@macro effect: 素材が示す魔法効果id

execute as @p[distance=..6] run function #oh_my_dat:please
$execute as @p[distance=..6] run function test:magic/registry/known_check {id:"$(effect)"}

$execute if score #known test.temporary matches 1 run function test:asset/magic/effect/$(effect)
