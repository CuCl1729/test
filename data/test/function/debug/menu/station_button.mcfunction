#> test:debug/menu/station_button
# @macro id/name/color: ステーションの種類・名前・色

$tellraw @s [{text:"[$(name)]",color:"$(color)",click_event:{action:"run_command",command:"/function test:debug/spawn_station {id:$(id)}"}},{text:" 足元に設置",color:"dark_gray"}]
