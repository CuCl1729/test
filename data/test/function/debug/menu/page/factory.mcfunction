#> test:debug/menu/page/factory
# @s = メニューを開いたプレイヤー。デバッグメニューの「工場」の欄(目次は test:debug/menu)

tellraw @s ""
tellraw @s [{text:"― 工場 ― ",color:gold},{text:"[目次]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/menu"}}]
tellraw @s [{text:"[工場の鍵]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/give_factory_key"}},{text:" "},{text:"[区画へ / 戻る]",color:aqua,click_event:{action:"run_command",command:"/function test:factory/use"}},{text:" (鍵と同じ動き)",color:dark_gray}]
tellraw @s [{text:"[区画の情報]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/factory_info"}},{text:" "},{text:"[番号を指定して移る…]",color:aqua,click_event:{action:"suggest_command",command:"/function test:debug/factory_goto {n:1}"}},{text:" (クリエイティブ向け)",color:dark_gray}]
