#> test:machine/ghost/clear
# @s = 機械のマーカー(実行位置は核の中心。#machine_owner = この機械の番号)。この機械のゴーストを全部消す

execute as @e[type=block_display,tag=machine_ghost,distance=..4] if score @s test.machine.id = #machine_owner test.temporary run kill @s
return 1
