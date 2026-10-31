#> test:gather/drop/loop
# @s = 採るプレイヤー。gather_work.drops([{material, rank, chance, chance_rank, min, max}])を1行ずつ:
# 必要ランク(rank)が #gather_rank 以下の行だけ、確率(%) = chance + chance_rank × ランク(100で頭打ち)で抽選する(rng のキー gather_drop)

execute unless data storage test: gather_work.drops[0] run return 0
execute store result score #gather_need test.temporary run data get storage test: gather_work.drops[0].rank
execute if score #gather_need test.temporary <= #gather_rank test.temporary run function test:gather/drop/row with storage test: gather_work.drops[0]
data remove storage test: gather_work.drops[0]
function test:gather/drop/loop
