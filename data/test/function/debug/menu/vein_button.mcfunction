#> test:debug/menu/vein_button
# @macro id: 鉱脈のid。「[id] [エッグ] 足元に設置(両マップ)」の1行を出す

$tellraw @s [{text:"[$(id)]",color:gold,click_event:{action:"run_command",command:"/function test:debug/spawn_vein {id:$(id)}"}},{text:" "},{text:"[エッグ]",color:aqua,click_event:{action:"run_command",command:"/function test:mine/egg/give {id:$(id)}"}},{text:" 足元か、エッグを使った所に設置(両マップ)",color:dark_gray}]
