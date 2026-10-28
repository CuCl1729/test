#> test:battle/grant_reward_to_player
# @s = 報酬を受け取るプレイヤー。#reward と battle.temporary(loot_table・equip_drops)は test:battle/grant_reward が用意する

scoreboard players operation @s test.status.exp += #reward test.temporary
execute unless data storage test: battle.temporary{loot_table:""} run function test:battle/grant_reward_loot with storage test: battle.temporary

# 完成品の装備(敵のdata.equip_dropsを1件ずつ抽選する)
function test:equip/drop/roll_all

# 転職の概念が無いため、解放済みの全職業へ同じ経験値を同時に与える(test:job/grant_exp_all)
function #oh_my_dat:please
function test:job/grant_exp_all
