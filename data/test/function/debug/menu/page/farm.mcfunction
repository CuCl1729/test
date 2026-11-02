#> test:debug/menu/page/farm
# @s = メニューを開いたプレイヤー。デバッグメニューの「農耕」の欄(目次は test:debug/menu)

tellraw @s ""
tellraw @s [{text:"― 農耕 ― ",color:gold},{text:"[目次]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/menu"}}]
tellraw @s [{text:"[魔法の種全種]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/give_magic_seeds"}},{text:" "},{text:"[普通の種]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/give_crop_seeds"}},{text:" "},{text:"[エッセンス全種]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/give_essences"}}]
tellraw @s [{text:"[近くの魔法作物]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/farm_status"}},{text:" "},{text:"[近くを育ちきらせる]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/farm_mature"}}]
