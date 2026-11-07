#> test:job/reset/buttons
# @s = プレイヤー。@macro ok/no: 押すと /trigger test.job_reset set <番号×10+1(実行)/+2(キャンセル)> になる値

$tellraw @s [{text:"[実行]",color:"red",click_event:{action:"run_command",command:"/trigger test.job_reset set $(ok)"}},{text:" "},{text:"[キャンセル]",color:"aqua",click_event:{action:"run_command",command:"/trigger test.job_reset set $(no)"}}]
