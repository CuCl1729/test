#> test:debug/menu/done
# @s = 操作したプレイヤー。@macro msg: 実行した内容。page: 戻るページ(test:debug/menu に続けるパス。"" なら目次、"/page/log" など)。
# メニューのボタンを押した後の確認と、そのページを開き直すボタンを出す

$tellraw @s [{text:"[DEBUG] $(msg) ",color:gray},{text:"[メニュー]",color:aqua,click_event:{action:"run_command",command:"/function test:debug/menu$(page)"}}]
