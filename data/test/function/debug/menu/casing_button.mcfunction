#> test:debug/menu/casing_button
# @s = メニューを開いたプレイヤー。@macro id: 筐体の種類。名前を引いて、ボタンの1行を出す

$data modify storage test: debug_work.casing_arg.name set from storage test: asset.casing.$(id).name
function test:debug/menu/casing_button_add with storage test: debug_work.casing_arg
