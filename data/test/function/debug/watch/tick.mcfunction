#> test:debug/watch/tick
# サイドバー表示がオンの間、test:debug/tickから毎tick呼ばれる。監視中のスコアをサイドバーの行へ写す

data modify storage test: debug_work.watch_tick_queue set from storage test: debug.watch
function test:debug/watch/tick_loop
