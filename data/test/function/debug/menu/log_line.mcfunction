#> test:debug/menu/log_line
# @macro cat/label: ログの種類(#log_<cat> test.debug.enabled)と表示名

$execute if score #log_$(cat) test.debug.enabled matches 1 run tellraw @s [{text:"$(label) ",color:gray},{text:"[ON]",color:green,bold:true},{text:" "},{text:"[OFF]",color:dark_gray,click_event:{action:"run_command",command:"/function test:debug/menu/set_log {cat:\"$(cat)\",label:\"$(label)\",value:0}"}}]
$execute unless score #log_$(cat) test.debug.enabled matches 1 run tellraw @s [{text:"$(label) ",color:gray},{text:"[ON]",color:dark_gray,click_event:{action:"run_command",command:"/function test:debug/menu/set_log {cat:\"$(cat)\",label:\"$(label)\",value:1}"}},{text:" "},{text:"[OFF]",color:red,bold:true}]
