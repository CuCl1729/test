#> test:talk/btn_show
# @s = プレイヤー。@macro v/label: ボタンの値とラベル

$tellraw @s {text:"[$(label)]",color:"aqua",hover_event:{action:"show_text",value:{text:"$(label)",color:"gray"}},click_event:{action:"run_command",command:"/trigger test.talk set $(v)"}}
