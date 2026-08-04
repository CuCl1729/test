function #oh_my_dat:please

say right_click
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".test{magic:1b} run \
data modify storage test: magic.player set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".test
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".test{magic:1b} run \
function test:magic/

execute if score @s test.battle.turn_order matches 1.. if score @s test.battle.turn_order = @e[tag=battle_marker,sort=nearest,limit=1] test.battle.current_turn run function test:battle/ui/item_check

advancement revoke @s only test:trigger/right_click/mainhand