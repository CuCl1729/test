#> test:debug/menu/station_line
# @s = メニューを開いたプレイヤー。@macro id: ステーションの種類。「[名前]」(押すと足元に設置)の1行を出す

$data modify storage test: debug_work.station_arg.name set from storage test: asset.station.$(id).name
$data modify storage test: debug_work.station_arg.color set from storage test: asset.station.$(id).color
function test:debug/menu/station_button with storage test: debug_work.station_arg
