#> test:battle/ui/target_minecart_toggle
# @s = 対象アイコンを取ったプレイヤー(トロッコ式)。$(index) = 取られたスロット番号(0〜7)

$execute store result score #picked_turn_order test.temporary run data get storage test: battle.temporary.target_slot[$(index)]

execute as @e[tag=battle_member,tag=enemy,distance=..64] if score @s test.battle.turn_order = #picked_turn_order test.temporary run function test:battle/ui/target_toggle

execute store result storage test: battle.temporary.clear_turn_order int 1 run scoreboard players get #picked_turn_order test.temporary
function test:battle/ui/target_minecart_toggle_clear with storage test: battle.temporary

function test:battle/ui/target_minecart_populate
