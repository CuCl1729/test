#> test:battle/ui/current_actor
# @s = 入力するプレイヤー。近くのアリーナで、現在の手番を持つかを返す。

execute unless entity @s[type=player,tag=battle_member] run return 0
execute unless score @n[tag=battle_marker,distance=..64] test.battle.acting matches 1 run return 0
execute unless score @s test.battle.id = @n[tag=battle_marker,distance=..64] test.battle.id run return 0
execute unless score @s test.battle.turn_order = @n[tag=battle_marker,distance=..64] test.battle.current_turn run return 0
return 1
