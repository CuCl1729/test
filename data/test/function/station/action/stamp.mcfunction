# @s = 台。描画する度に新しい番号を発行し、台の枠とボタンに同じ番号を記録する。
scoreboard players add #station_ticket test.time 1
$execute store result entity @s data.station.buttons.s$(slot) int 1 run scoreboard players get #station_ticket test.time
$data remove storage test: $(item).components."minecraft:custom_data".test.crafter_ui
$data remove storage test: $(item).components."minecraft:custom_data".test.job_ui
$data modify storage test: $(item).components."minecraft:custom_data".test.station_action.ticket set from entity @s data.station.buttons.s$(slot)
