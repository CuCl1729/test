#> test:gather/look_after
# @s = 採取ポイント(interaction)。@macro after: 採った後の見た目(空のときは生成スクリプトが air にしてある。ほかのキーも渡ってくるが使わない)

$execute at @s align xyz as @e[type=block_display,tag=gather_display,distance=..0.1] run data modify entity @s block_state set value {id:"$(after)"}
