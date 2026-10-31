#> test:debug/fishing_here
# @s = プレイヤー。今いる場所(浮きではなく自分の位置)が範囲に入る釣り場の行を、上から順に出す(天気・時間帯の条件も出す)。
# 実際に釣れるのは、その中で天気・時間帯が当てはまる最初の行。どれにも当てはまらなければ default

tag @s add debug_fish_viewer
tellraw @s {text:"― ここの釣り場(上ほど優先) ―",color:"gold"}
data modify storage test: debug_work.fish_queue set from storage test: asset.fishing_spots
execute at @s run function test:debug/fishing_here_loop
tellraw @s {text:" どれにも当てはまらなければ default",color:"gray"}
tag @s remove debug_fish_viewer
