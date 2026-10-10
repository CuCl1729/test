#> test:debug/menu/watch_loop
# storage test: debug_work.watch_queue(監視中の一覧のコピー)を1件ずつ、今の値と[×]付きで表示する

execute unless data storage test: debug_work.watch_queue[0] run return 0

function test:debug/menu/watch_line with storage test: debug_work.watch_queue[0]

data remove storage test: debug_work.watch_queue[0]
function test:debug/menu/watch_loop
