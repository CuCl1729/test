#> test:debug/menu/page/item
# @s = メニューを開いたプレイヤー。デバッグメニューの「アイテム」の欄(目次は test:debug/menu)

tellraw @s ""
tellraw @s [{text:"― アイテム ― ",color:gold},{text:"[目次]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/menu"}}]
tellraw @s [{text:"[素材全種]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/give_materials"}},{text:" (工房の材料・触媒・特殊素材・型紙)",color:dark_gray}]
tellraw @s [{text:"[ルーン全種]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/give_runes"}},{text:" "},{text:"[消耗品全種×16]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/give_consumables"}},{text:" (強化台の付与モードで装備の枠に入れる)",color:dark_gray}]
