#> test:mine/rescue
# @macro dim/x1/y1/z1/dx/dy/dz/ex/ey/ez: マップ・鉱山の範囲・入口。範囲の中にいて、足元か頭の位置が
# ブロックで埋まった(リセットで鉱石が戻った)人を入口へ移す

$execute in test:$(dim) positioned $(x1) $(y1) $(z1) as @a[dx=$(dx),dy=$(dy),dz=$(dz)] at @s unless block ~ ~ ~ #minecraft:air run tag @s add mine_rescue
$execute in test:$(dim) positioned $(x1) $(y1) $(z1) as @a[dx=$(dx),dy=$(dy),dz=$(dz)] at @s unless block ~ ~1 ~ #minecraft:air run tag @s add mine_rescue
$execute in test:$(dim) run tp @a[tag=mine_rescue] $(ex) $(ey) $(ez)
tag @a remove mine_rescue
