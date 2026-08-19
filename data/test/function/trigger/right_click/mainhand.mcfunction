function #oh_my_dat:please

execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".test{magic:1b} run \
data modify storage test: magic.player set from storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".test
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".test{magic:1b} run \
function test:magic/

# 範囲攻撃剣(右クリック)。test:attack/damageが戦闘中の対象を除外するため、バトル中かどうかのゲートは不要
execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".test{aoe_attack:1b} run \
function test:attack/aoe

execute if score @s test.battle.turn_order matches 1.. if score @s test.battle.turn_order = @e[tag=battle_marker,sort=nearest,limit=1] test.battle.current_turn run function test:battle/ui/item_check

execute if data storage oh_my_dat: _[-4][-4][-4][-4][-4][-4][-4][-4].player_data.SelectedItem.components."minecraft:custom_data".test{status_check:1b} run function test:ui/status/check

advancement revoke @s only test:trigger/right_click/mainhand