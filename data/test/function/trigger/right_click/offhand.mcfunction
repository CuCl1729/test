function #oh_my_dat:please

execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.offhand.components."minecraft:custom_data".test{magic:1b} run \
data modify storage test: magic.player set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.offhand.components."minecraft:custom_data".test
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.equipment.offhand.components."minecraft:custom_data".test{magic:1b} run \
function test:magic/

advancement revoke @s only test:trigger/right_click/offhand