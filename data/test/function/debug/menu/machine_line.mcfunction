#> test:debug/menu/machine_line
# @s = メニューを開いたプレイヤー。@macro id: 機械の種類。「[名前] [エッグ] [足元に設置]」の1行を出す

$data modify storage test: debug_work.machine_arg.name set from storage test: asset.machine.$(id).name
function test:debug/menu/machine_button with storage test: debug_work.machine_arg
