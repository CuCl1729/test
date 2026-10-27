#> test:buff/notify_expire
# @s = バフ保持者。@macro = レジストリ1件(label と color を使う)

$execute at @s if dimension test:arena run tellraw @a[distance=..64] ["",{selector:"@s"},{text:" の ",color:gray},{text:"$(label)",color:"$(color)"},{text:" が切れた",color:gray}]
$execute at @s unless dimension test:arena run tellraw @a[distance=..32] ["",{selector:"@s"},{text:" の ",color:gray},{text:"$(label)",color:"$(color)"},{text:" が切れた",color:gray}]
