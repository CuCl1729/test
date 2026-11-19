#> test:debug/menu/page/magic
# @s = メニューを開いたプレイヤー。デバッグメニューの「魔法」の欄(目次は test:debug/menu)

tellraw @s ""
tellraw @s [{text:"― 魔法 ― ",color:gold},{text:"[目次]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/menu"}}]
tellraw @s [{text:"[組み合わせ一覧]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/combo_list"}},{text:" "},{text:"[近くの持続物]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/cont_status"}}]
tellraw @s [{text:"[持続物を全部消す]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/cont_clear"}}]
