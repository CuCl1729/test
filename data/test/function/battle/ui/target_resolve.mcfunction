#> test:battle/ui/target_resolve
# @s = 対象選択(トグル/決定)を行ったプレイヤー(チャット式)。決定は999固定、それ以外はturn_orderの値

scoreboard players operation #target_select test.battle.target_select = @s test.battle.target_select
scoreboard players set @s test.battle.target_select 0

execute if score #target_select test.battle.target_select matches 1..998 as @e[tag=battle_member,tag=enemy,distance=..64] if score @s test.battle.turn_order = #target_select test.battle.target_select run function test:battle/ui/target_toggle

execute if score #target_select test.battle.target_select matches 1..998 run scoreboard players enable @s test.battle.target_select
execute if score #target_select test.battle.target_select matches 1..998 run function test:battle/ui/target_display

execute if score #target_select test.battle.target_select matches 999 unless entity @e[tag=battle_target] run scoreboard players enable @s test.battle.target_select
execute if score #target_select test.battle.target_select matches 999 if entity @e[tag=battle_target] run function test:battle/ui/target_confirm
