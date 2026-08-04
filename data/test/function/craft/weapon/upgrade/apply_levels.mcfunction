#> test:craft/weapon/upgrade/apply_levels
# @s = 強化炉マーカー。#upgrade_count(test.temporary)の回数だけ item/weapon/level_up/ を実行する再帰関数

execute if score #upgrade_count test.temporary matches 1.. run function test:item/weapon/level_up/
execute if score #upgrade_count test.temporary matches 1.. run scoreboard players remove #upgrade_count test.temporary 1
execute if score #upgrade_count test.temporary matches 1.. run function test:craft/weapon/upgrade/apply_levels
