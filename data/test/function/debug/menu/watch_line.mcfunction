#> test:debug/menu/watch_line
# @macro name/objective: 監視中の1件

$tellraw @s [{text:"・$(name) $(objective) = ",color:white},{score:{name:"$(name)",objective:"$(objective)"},color:yellow},{text:" "},{text:"[×]",color:red,click_event:{action:"run_command",command:"/function test:debug/watch/remove {name:\"$(name)\",objective:\"$(objective)\"}"}}]
