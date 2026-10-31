#> test:debug/menu/fish_button
# @macro id: 中身のid

$tellraw @s [{text:"[$(id)]",color:"aqua",click_event:{action:"run_command",command:"/function test:debug/give_fish_token {id:$(id)}"}},{text:" の目印",color:"dark_gray"}]
