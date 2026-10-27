#> test:battle/ui/clear_items_pick_loop
# @s = プレイヤー。対象アイコン(target_pick:<turn_order>)を #clear_pick から16まで順に手元から消す
# (1つの戦闘の参加者はこれより少ない)

execute store result storage test: battle.temporary.clear_turn_order int 1 run scoreboard players get #clear_pick test.temporary
function test:battle/ui/target_minecart_toggle_clear with storage test: battle.temporary

scoreboard players add #clear_pick test.temporary 1
execute if score #clear_pick test.temporary matches ..16 run function test:battle/ui/clear_items_pick_loop
