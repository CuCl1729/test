#> test:debug/remove_vein
# @s = プレイヤー。2ブロック以内の鉱脈のアマスタを消す

execute store result score #vein_removed test.temporary at @s if entity @e[type=armor_stand,tag=mine_vein,distance=..2]
execute at @s run kill @e[type=armor_stand,tag=mine_vein,distance=..2]
tellraw @s [{text:"鉱脈を消した: ",color:gray},{score:{name:"#vein_removed",objective:"test.temporary"},color:aqua},{text:"個",color:gray}]
