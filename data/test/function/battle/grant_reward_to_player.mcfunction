#> test:battle/grant_reward_to_player
# @s = 報酬を受け取るプレイヤー。#reward と battle.temporary(material_hits・equip_hits)は test:battle/grant_reward が
# 抽選して用意する。ここでは配るだけ(装備のレア度などの中身だけは、受け取る人ごとに抽選する)

scoreboard players operation @s test.status.exp += #reward test.temporary

# 素材(全員に同じ種類・同じ個数)
function test:item/material/give_hits

# 完成品の装備(落ちたものを全員に。中身は人ごとに test:equip/drop/give が抽選する)
function test:equip/drop/give_all

# 転職の概念が無いため、解放済みの全職業へ同じ経験値を同時に与える(test:job/grant_exp_all)
function #oh_my_dat:please
function test:job/grant_exp_all
