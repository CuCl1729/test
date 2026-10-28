#> test:battle/ui/item_poll
# @s = 戦闘マーカー。現在手番のプレイヤーが使うアイテムを選んでいれば処理する(チャット式、awaiting_skill=7)

scoreboard players operation #battle_turn test.battle.id = @s test.battle.id
scoreboard players operation #battle_turn test.battle.current_turn = @s test.battle.current_turn

execute at @s as @a[tag=battle_member,distance=..64,scores={test.battle.item_select=1..}] if score @s test.battle.id = #battle_turn test.battle.id if score @s test.battle.turn_order = #battle_turn test.battle.current_turn run function test:battle/ui/item_resolve
