#> test:battle/target/clear
# @s = その戦闘の参加者(行動している人、選ばれた敵、戦闘マーカーのどれでもよい)。
# @sと同じ戦闘(test.battle.id)の battle_target だけを外す。他のアリーナで選択中の対象は残す

scoreboard players operation #target_battle test.battle.id = @s test.battle.id
execute as @e[tag=battle_target] if score @s test.battle.id = #target_battle test.battle.id run tag @s remove battle_target
