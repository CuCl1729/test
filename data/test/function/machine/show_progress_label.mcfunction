#> test:machine/show_progress_label
# @s = 処理中の機械のマーカー。@macro p: 進み(%)

$function test:machine/status {label:"処理中 $(p)%",color:"green"}
