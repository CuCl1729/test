#> test:battle/enemy_ai/part/target_all
# @s = 手番の敵。@macro fn: test:battle/enemy_ai/part/<fn> を、同じ戦闘(#target_battle)で生きているプレイヤー全員として実行する

$execute as @a[tag=battle_member,distance=..64,scores={test.status.hp=1..}] if score @s test.battle.id = #target_battle test.battle.id run function test:battle/enemy_ai/part/$(fn)
