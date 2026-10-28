#> test:battle/ui/cleanup
# @s = 手番のプレイヤー(at @s)。行動を選び終えないまま手番を終えるとき(時間切れ)に、行動UIを丸ごと片付ける。
# 選択待ち(awaiting_*)が残ると戦闘マーカーが次の手番に進めないので、必ず0に戻す

function test:battle/ui/clear_items

execute as @e[tag=skill_minecart,distance=..8] run data remove entity @s Items
kill @e[tag=skill_minecart,distance=..8]
execute as @e[tag=item_minecart,distance=..8] run data remove entity @s Items
kill @e[tag=item_minecart,distance=..8]

scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.awaiting_skill 0
scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.awaiting_target 0
scoreboard players set @s test.battle.pending_target_action 0

function test:battle/target/clear
