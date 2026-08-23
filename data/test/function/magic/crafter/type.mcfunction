#> test:magic/crafter/type
# @s = クラフター本体。@macro type: 素材が示す魔法タイプid
# 習得済みかはoh_my_datの個別ストレージを見る(#oh_my_datはクラフターを使っているプレイヤーとして呼ぶ)

execute as @p[distance=..6] run function #oh_my_dat:please
$execute as @p[distance=..6] run function test:magic/registry/known_check {id:"$(type)"}

$execute if score #known test.temporary matches 1 run function test:asset/magic/type/$(type)
