#> test:debug/menu/vein_button
# @macro id: 鉱脈のid。「[id] 足元に設置(両マップ)」の1行を出す

$tellraw @s [{text:"[$(id)]",color:gold,click_event:{action:"run_command",command:"/function test:debug/spawn_vein {id:$(id)}"}},{text:" 足元に設置(両マップ)",color:dark_gray}]
