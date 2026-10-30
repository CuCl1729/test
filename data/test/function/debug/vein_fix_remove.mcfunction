#> test:debug/vein_fix_remove
# @s = プレイヤー。@macro dim/x/y/z: test:debug/check_veins の一覧から、片方のマップの1か所の鉱脈のアマスタを消す

$execute store result score #vein_ok test.temporary run function test:debug/vein_loaded {x:$(x),y:$(y),z:$(z)}
execute if score #vein_ok test.temporary matches 0 run return 0
scoreboard players set #vein_removed test.temporary 0
$function test:debug/vein_kill {dim:"$(dim)",x:$(x),y:$(y),z:$(z),r:0.5}
$tellraw @s [{text:"鉱脈を消した: ",color:gray},{score:{name:"#vein_removed",objective:"test.temporary"},color:aqua},{text:"個($(dim) $(x) $(y) $(z))",color:gray}]
