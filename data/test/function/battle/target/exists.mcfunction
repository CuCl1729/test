#> test:battle/target/exists
# @s = その戦闘の参加者(行動している人、選ばれた敵、戦闘マーカーのどれでもよい)。
# @sと同じ戦闘(test.battle.id)で battle_target が付いたものがいれば1、いなければ0を返す。
# アリーナは最大4つ同時に動くので、battle_target は必ず戦闘IDで絞って参照する

scoreboard players operation #target_battle test.battle.id = @s test.battle.id
execute as @e[tag=battle_target] if score @s test.battle.id = #target_battle test.battle.id run return 1
return 0
