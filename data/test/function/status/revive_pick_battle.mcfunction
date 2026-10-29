#> test:status/revive_pick_battle
# @s = 蘇生を使うプレイヤー(ターン制の戦闘中)。同じ戦闘で倒れているプレイヤーを1人選んで revive_target を付ける。
# 選べたら1、いなければ0を返す

scoreboard players operation #revive_battle test.battle.id = @s test.battle.id
execute as @a[tag=battle_member,scores={test.status.hp=..0}] if score @s test.battle.id = #revive_battle test.battle.id run return run tag @s add revive_target
return 0
