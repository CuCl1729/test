#> test:battle/ui/chat_poll
# @s = 戦闘マーカー。現在手番のプレイヤーがチャットUIで行動を選択済みなら処理する

scoreboard players operation #battle_turn test.battle.id = @s test.battle.id
scoreboard players operation #battle_turn test.battle.current_turn = @s test.battle.current_turn

execute as @a[tag=battle_member,distance=..64,scores={test.battle.chat_select=1..}] if score @s test.battle.id = #battle_turn test.battle.id if score @s test.battle.turn_order = #battle_turn test.battle.current_turn run function test:battle/ui/chat_select
