#> test:debug/flag_set
# @s = プレイヤー。@macro name/value: 自分のフラグ(oh_my_dat の test.flag.<名前>)に値を書く

function #oh_my_dat:please
$data modify storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].test.flag.$(name) set value $(value)
function test:debug/flags
