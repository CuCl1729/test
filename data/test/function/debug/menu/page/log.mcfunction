#> test:debug/menu/page/log
# @s = メニューを開いたプレイヤー。デバッグメニューの「ログ」の欄(目次は test:debug/menu)

tellraw @s ""
tellraw @s [{text:"― ログ ― ",color:gold},{text:"[目次]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/menu"}}]
function test:debug/menu/log_line {cat:"damage",label:"ダメージ計算"}
function test:debug/menu/log_line {cat:"battle",label:"戦闘の進行"}
