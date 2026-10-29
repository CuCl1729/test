#> test:debug/reset_mine_area
# @s = プレイヤー。@macro id/dim/x1/y1/z1/dx/dy/dz: 鉱山のid・マップ・範囲。@s が範囲の中にいれば元に戻す

$execute in test:$(dim) positioned $(x1) $(y1) $(z1) unless entity @s[dx=$(dx),dy=$(dy),dz=$(dz)] run return 0
scoreboard players set #mine_found test.temporary 1
$function test:mine/reset {id:"$(id)",dim:"$(dim)"}
$tellraw @s [{text:"鉱山リセット: $(id)",color:gray}]
