#> test:machine/show_progress_label
# @s = 処理中の機械のマーカー。@macro p/t: 進み(秒)と1回の秒数

$function test:machine/status {label:"処理中 $(p)/$(t)",color:"green"}
