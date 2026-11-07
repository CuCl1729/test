# @s = 台。call は呼び出し元の定数。アイテムに書かれた関数やレシピを実行しない。
scoreboard players set #station_claimed test.temporary 0
$execute unless data entity @s data.station.buttons.s$(slot) run return 0
$data modify storage test: station_action.ticket set from entity @s data.station.buttons.s$(slot)
$data remove entity @s data.station.buttons.s$(slot)
$data modify storage test: station_action.call set value "$(call)"
function test:station/action/find with storage test: station_action
