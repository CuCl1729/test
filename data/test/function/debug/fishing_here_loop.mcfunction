#> test:debug/fishing_here_loop
# 実行位置 = プレイヤー。debug_work.fish_queue(asset.fishing_spots のコピー)を1行ずつ見る

execute unless data storage test: debug_work.fish_queue[0] run return 0
function test:debug/fishing_here_line with storage test: debug_work.fish_queue[0]
data remove storage test: debug_work.fish_queue[0]
function test:debug/fishing_here_loop
