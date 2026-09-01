#> test:buff/notify_apply_stacked
# @s = 付与対象。@macro = レジストリ1件 + stacks(付与後のスタック数)
# 重ねがけできるバフ用。現在のスタック数と上限を出して、頭打ちになったことが分かるようにする

$tellraw @a ["",{selector:"@s"},{text:" は ",color:gray},{text:"$(label)",color:"$(color)"},{text:" x$(stacks)/$(max_stacks)",color:"$(color)"},{text:" 状態になった！",color:gray}]
