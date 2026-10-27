#> test:battle/ui/target_resolve
# @s = 対象選択(トグル/決定)を行ったプレイヤー(チャット式)。決定は999固定、それ以外はturn_orderの値

scoreboard players operation #target_select test.battle.target_select = @s test.battle.target_select
scoreboard players set @s test.battle.target_select 0

# target_toggleは敵を@sにして呼ぶので、手番の人(@s)の選択できる数をここで控えておく
scoreboard players operation #target_max test.battle.target_max = @s test.battle.target_max
execute if score #target_select test.battle.target_select matches 1..998 as @e[tag=battle_member,tag=enemy,distance=..64] if score @s test.battle.turn_order = #target_select test.battle.target_select run function test:battle/ui/target_toggle

execute if score #target_select test.battle.target_select matches 1..998 run scoreboard players enable @s test.battle.target_select
execute if score #target_select test.battle.target_select matches 1..998 run function test:battle/ui/target_display

# 選択済みの対象がいるかは、同じ戦闘のものだけで見る
execute store result score #has_target test.temporary run function test:battle/target/exists
execute if score #target_select test.battle.target_select matches 999 if score #has_target test.temporary matches 0 run scoreboard players enable @s test.battle.target_select
execute if score #target_select test.battle.target_select matches 999 if score #has_target test.temporary matches 1 run function test:battle/ui/target_confirm
