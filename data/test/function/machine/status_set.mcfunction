#> test:machine/status_set
# @s = 機械の頭上の表示(text_display)。@macro name/label/color: 名前・状態・状態の色

$data modify entity @s text set value {text:"$(name) ",color:"white",extra:[{text:"[$(label)]",color:"$(color)"}]}
