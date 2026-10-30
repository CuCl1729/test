#> test:mine/rescue
# @macro dim/x1/y1/z1/dx/dy/dz/ex/ey/ez: マップ・鉱山の範囲・入口。範囲の中にいて、足元か頭の位置が
# 鉱脈の鉱石ブロック(#test:mine_ores。生成スクリプトが全鉱脈の鉱石ブロックから作る)で埋まった人を入口へ移す。
# リセットで戻るのは鉱石だけ(構造物の鉱石以外はストラクチャーヴォイド)なので、たいまつ・レール・水などの位置に
# 立っているだけの人は移さない

$execute in test:$(dim) positioned $(x1) $(y1) $(z1) as @a[dx=$(dx),dy=$(dy),dz=$(dz)] at @s if block ~ ~ ~ #test:mine_ores run tag @s add mine_rescue
$execute in test:$(dim) positioned $(x1) $(y1) $(z1) as @a[dx=$(dx),dy=$(dy),dz=$(dz)] at @s if block ~ ~1 ~ #test:mine_ores run tag @s add mine_rescue
$execute in test:$(dim) run tp @a[tag=mine_rescue] $(ex) $(ey) $(ez)
tag @a remove mine_rescue
