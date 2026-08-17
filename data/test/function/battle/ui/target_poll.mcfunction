#> test:battle/ui/target_poll
# @s = 戦闘マーカー。現在手番のプレイヤーが対象選択(トグル/決定)を行ったか確認する(チャット式)

scoreboard players operation #battle_turn test.battle.id = @s test.battle.id
scoreboard players operation #battle_turn test.battle.current_turn = @s test.battle.current_turn

execute at @s as @a[tag=battle_member,distance=..64,scores={test.battle.target_select=1..}] if score @s test.battle.id = #battle_turn test.battle.id if score @s test.battle.turn_order = #battle_turn test.battle.current_turn run function test:battle/ui/target_resolve
