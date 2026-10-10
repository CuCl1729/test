#> test:debug/inspect/nearest
# @s = 操作したプレイヤー。16ブロック以内で最も近い、HPを持つプレイヤー以外のエンティティの状態を表示する

execute at @s unless entity @e[type=!player,scores={test.status.hp_max=1..},distance=..16] run return run function test:debug/menu/done {msg:"16ブロック以内に対象がいません"}

tag @s add debug_viewer
execute at @s as @n[type=!player,scores={test.status.hp_max=1..},distance=..16] run function test:debug/inspect/show
tag @s remove debug_viewer
