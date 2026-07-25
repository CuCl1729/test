#> test:battle/turn_end
# @s = 行動を終えたエンティティ

scoreboard players add @e[tag=battle_marker,sort=nearest,limit=1] test.battle.current_turn 1
execute if score @e[tag=battle_marker,sort=nearest,limit=1] test.battle.current_turn > @e[tag=battle_marker,sort=nearest,limit=1] test.battle.member_count run scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.current_turn 1

scoreboard players set @e[tag=battle_marker,sort=nearest,limit=1] test.battle.acting 0