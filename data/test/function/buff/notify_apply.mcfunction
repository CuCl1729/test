#> test:buff/notify_apply
# @s = 付与対象。@macro = レジストリ1件(label と color を使う)

$execute at @s if dimension test:arena run tellraw @a[distance=..64] ["",{selector:"@s"},{text:" は ",color:gray},{text:"$(label)",color:"$(color)"},{text:" 状態になった！",color:gray}]
$execute at @s unless dimension test:arena run tellraw @a[distance=..32] ["",{selector:"@s"},{text:" は ",color:gray},{text:"$(label)",color:"$(color)"},{text:" 状態になった！",color:gray}]
