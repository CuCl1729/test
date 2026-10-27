#> test:buff/notify_apply_stacked
# @s = 付与対象。@macro = レジストリ1件 + stacks(付与後のスタック数)
# 重ねがけできるバフ用。現在のスタック数と上限を出して、頭打ちになったことが分かるようにする

$execute at @s if dimension test:arena run tellraw @a[distance=..64] ["",{selector:"@s"},{text:" は ",color:gray},{text:"$(label)",color:"$(color)"},{text:" x$(stacks)/$(max_stacks)",color:"$(color)"},{text:" 状態になった！",color:gray}]
$execute at @s unless dimension test:arena run tellraw @a[distance=..32] ["",{selector:"@s"},{text:" は ",color:gray},{text:"$(label)",color:"$(color)"},{text:" x$(stacks)/$(max_stacks)",color:"$(color)"},{text:" 状態になった！",color:gray}]
