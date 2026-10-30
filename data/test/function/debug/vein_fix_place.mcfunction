#> test:debug/vein_fix_place
# @s = プレイヤー。@macro dim/x/y/z/id: test:debug/check_veins の一覧から、片方のマップの1か所に鉱脈のアマスタを置く

$execute unless data storage test: asset.vein.$(id) run return run tellraw @s [{text:"鉱脈「$(id)」はありません",color:gray}]
$execute store result score #vein_ok test.temporary run function test:debug/vein_loaded {x:$(x),y:$(y),z:$(z)}
execute if score #vein_ok test.temporary matches 0 run return 0
$function test:debug/vein_place {dim:"$(dim)",x:$(x),y:$(y),z:$(z),id:"$(id)"}
$tellraw @s [{text:"鉱脈を置いた: $(id)($(dim) $(x) $(y) $(z))",color:gray}]
