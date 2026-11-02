#> test:debug/menu/page/npc
# @s = メニューを開いたプレイヤー。デバッグメニューの「NPC・クエスト」の欄(目次は test:debug/menu)

tellraw @s ""
tellraw @s [{text:"― NPC・クエスト ― ",color:gold},{text:"[目次]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/menu"}}]
tellraw @s [{text:"[NPCの一覧]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/npc_list"}},{text:" (押すと移動)",color:dark_gray}]
tellraw @s [{text:"[クエストの状態]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/quest_list"}},{text:" "},{text:"[フラグ]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/flags"}},{text:" (/trigger test.quest で一覧)",color:dark_gray}]
tellraw @s [{text:"[口座+100G]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/money_add"}},{text:" "},{text:"[コイン123G]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/money_coins"}}]
