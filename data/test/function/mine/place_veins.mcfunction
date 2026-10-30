#> test:mine/place_veins
# @macro dim/x1/y1/z1/dx/dy/dz: マップと鉱山の範囲。範囲の中の鉱脈のアマスタに、自分の鉱脈を置き直させる

$execute in test:$(dim) positioned $(x1) $(y1) $(z1) as @e[type=armor_stand,tag=mine_vein,dx=$(dx),dy=$(dy),dz=$(dz)] at @s run function test:mine/place_vein with entity @s data
