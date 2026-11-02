#> test:debug/menu/page/watch
# @s = メニューを開いたプレイヤー。デバッグメニューの「監視(サイドバー)」の欄(目次は test:debug/menu)

tellraw @s ""
tellraw @s [{text:"― 監視(サイドバー) ― ",color:gold},{text:"[目次]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/menu"}}]
data modify storage test: debug_work.watch_queue set value []
data modify storage test: debug_work.watch_queue set from storage test: debug.watch
function test:debug/menu/watch_loop
execute unless data storage test: debug.watch[0] run tellraw @s {text:"(監視中の値はありません)",color:dark_gray}
tellraw @s [{text:"[追加…]",color:aqua,click_event:{action:"suggest_command",command:"/function test:debug/watch/add {name:\"#damage\",objective:\"test.physics_damage\"}"}},{text:" "},{text:"[全部消す]",color:red,click_event:{action:"run_command",command:"/function test:debug/watch/clear"}}]
