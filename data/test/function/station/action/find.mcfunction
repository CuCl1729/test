# 実行位置は台のまま。クリックでもShiftクリックでも、該当番号を持っている人だけを対象にする。
data modify storage test: station_action.dest set value "player.cursor"
$execute as @a[distance=..6] if items entity @s player.cursor *[custom_data~{test:{station_action:{ticket:$(ticket)}}}] run function test:station/action/fire with storage test: station_action
data modify storage test: station_action.dest set value "weapon.offhand"
$execute as @a[distance=..6] if items entity @s weapon.offhand *[custom_data~{test:{station_action:{ticket:$(ticket)}}}] run function test:station/action/fire with storage test: station_action
$execute as @a[distance=..6] if items entity @s container.* *[custom_data~{test:{station_action:{ticket:$(ticket)}}}] run function test:station/action/inventory with storage test: station_action
