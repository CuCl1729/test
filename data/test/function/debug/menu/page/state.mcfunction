#> test:debug/menu/page/state
# @s = メニューを開いたプレイヤー。デバッグメニューの「状態の表示」の欄(目次は test:debug/menu)

tellraw @s ""
tellraw @s [{text:"― 状態の表示 ― ",color:gold},{text:"[目次]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/menu"}}]
tellraw @s [{text:"[自分]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/inspect/self"}},{text:" "},{text:"[近くの対象]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/inspect/nearest"}},{text:" (16ブロック以内で最も近い、HPを持つプレイヤー以外)",color:dark_gray}]
