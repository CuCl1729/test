#> test:machine/status
# @s = 機械のマーカー。@macro label/color: 状態(未完成・燃料切れ・待機・処理中 2/4 など)と色。
# 頭上の表示(text_display、tag=machine_label)を「<名前> [<状態>]」にする。名前は machine_work.def.name

$data modify storage test: machine_work.status set value {label:"$(label)",color:"$(color)",name:""}
data modify storage test: machine_work.status.name set from storage test: machine_work.def.name
execute on passengers if entity @s[tag=machine_label] run function test:machine/status_set with storage test: machine_work.status
