#> test:debug/watch/clear
# 監視をすべてやめ、サイドバーの行も消す

data modify storage test: debug_work.watch_queue set value []
data modify storage test: debug_work.watch_queue set from storage test: debug.watch
function test:debug/watch/clear_loop
data modify storage test: debug.watch set value []

function test:debug/menu/done {msg:"監視をすべて外しました"}
