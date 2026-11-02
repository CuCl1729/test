#> test:debug/menu/page/research
# @s = メニューを開いたプレイヤー。デバッグメニューの「研究」の欄(目次は test:debug/menu)

tellraw @s ""
tellraw @s [{text:"― 研究 ― ",color:gold},{text:"[目次]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/menu"}}]
tellraw @s [{text:"[観測鏡]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/give_scanner"}},{text:" "},{text:"[知識+10]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/research_knowledge"}},{text:" "},{text:"[調べ済みと知識]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/research_show"}}]
tellraw @s [{text:"[全部研究する]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/research_all"}},{text:" "},{text:"[研究を全部消す]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/research_reset"}},{text:" (知識・調べ済みも)",color:dark_gray}]
