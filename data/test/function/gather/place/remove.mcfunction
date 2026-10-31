#> test:gather/place/remove
# @s = 採取ポイント(interaction)。見た目(block_display)ごと消す

execute at @s align xyz run kill @e[type=block_display,tag=gather_display,distance=..0.1]
kill @s
return 1
