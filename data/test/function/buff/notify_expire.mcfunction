#> test:buff/notify_expire
# @s = バフ保持者。@macro = レジストリ1件(label と color を使う)

$tellraw @a ["",{selector:"@s"},{text:" の ",color:gray},{text:"$(label)",color:"$(color)"},{text:" が切れた",color:gray}]
