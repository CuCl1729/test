#> test:debug/menu/page/enemy
# @s = メニューを開いたプレイヤー。デバッグメニューの「敵」の欄(目次は test:debug/menu)

tellraw @s ""
tellraw @s [{text:"― 敵 ― ",color:gold},{text:"[目次]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/menu"}}]
data modify storage test: debug_work.enemy_queue set from storage test: asset.enemy_ids
function test:debug/menu/enemy_loop
