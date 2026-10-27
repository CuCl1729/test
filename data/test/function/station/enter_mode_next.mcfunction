#> test:station/enter_mode_next
# @macro next_index: 次のモードの番号。その定義を station_work.next に写す

$data modify storage test: station_work.next set from storage test: station_work.def.modes[$(next_index)]
