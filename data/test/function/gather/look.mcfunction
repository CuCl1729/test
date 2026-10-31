#> test:gather/look
# @s = 採取ポイント(interaction)。@macro block: 採れるときの見た目(ほかのキーも渡ってくるが使わない)

$execute at @s align xyz as @e[type=block_display,tag=gather_display,distance=..0.1] run data modify entity @s block_state set value {id:"$(block)"}
