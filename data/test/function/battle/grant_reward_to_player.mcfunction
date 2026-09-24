scoreboard players operation @s test.status.exp += #reward test.temporary
$loot give @s loot $(loot_table)

# 転職の概念が無いため、解放済みの全職業へ同じ経験値を同時に与える(test:job/grant_exp_all)
function #oh_my_dat:please
function test:job/grant_exp_all