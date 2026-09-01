#> test:buff/notify_apply
# @s = 付与対象。@macro = レジストリ1件(label と color を使う)

$tellraw @a ["",{selector:"@s"},{text:" は ",color:gray},{text:"$(label)",color:"$(color)"},{text:" 状態になった！",color:gray}]
