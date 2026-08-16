#> test:battle/tick
# @s = 戦闘マーカー
# test.battle.awaiting_skill: 0=なし 1=スキルのタイプ選択待ち(チャット式) 2=同(トロッコ式)

execute at @s as @a[tag=battle_member,distance=..64] at @s run function test:battle/ui/skill_hover_tick

execute unless score @s test.battle.acting matches 1 run function test:battle/turn_start
execute if score @s test.battle.acting matches 1 if score @s test.battle.awaiting_skill matches 1 run function test:battle/ui/skill_poll
execute if score @s test.battle.acting matches 1 if score @s test.battle.awaiting_skill matches 2 run function test:battle/ui/skill_minecart_poll
execute if score @s test.battle.acting matches 1 unless score @s test.battle.awaiting_skill matches 1.. if score @s test.battle.enemy_delay matches 1.. run function test:battle/enemy_delay_tick
execute if score @s test.battle.acting matches 1 unless score @s test.battle.awaiting_skill matches 1.. unless score @s test.battle.enemy_delay matches 1.. run function test:battle/ui/chat_poll
