data modify storage test: attack.player set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components.minecraft:custom_data

execute store result score @s test.repeat run data get storage test: attack.player.weapon[{type:"reach"}].value

function test:attack/prepare_damage
