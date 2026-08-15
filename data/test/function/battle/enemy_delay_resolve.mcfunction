#> test:battle/enemy_delay_resolve
# @s = 戦闘マーカー。間が空けた後、実際に手番の敵へ行動させる

scoreboard players operation #battle_turn test.battle.id = @s test.battle.id
scoreboard players operation #battle_turn test.battle.current_turn = @s test.battle.current_turn

execute at @s as @e[tag=battle_member,tag=enemy,distance=..64] if score @s test.battle.id = #battle_turn test.battle.id if score @s test.battle.turn_order = #battle_turn test.battle.current_turn run function test:battle/action/attack
