#> test:machine/pre/finish
# @s = 前処理の機械のマーカー。machine_work.ore = 処理した原石。
# 1. 段階を1つ増やした加工途中の原石を、必ず1個出す(抽選しない)
# 2. 副産物: asset.pre_by.<機械>.<原石> の行を1行ずつ判定する(rng のキー pre_by。確率 = chance + chance_rare × (レア度−1))

scoreboard players operation #ore_next test.temporary = #ore_stage test.temporary
scoreboard players add #ore_next test.temporary 1
execute store result storage test: machine_work.ore.next int 1 run scoreboard players get #ore_next test.temporary
function test:machine/pre/product with storage test: machine_work.ore

data modify storage test: machine_work.by set value []
function test:machine/pre/load_by with storage test: machine_work.ore
data modify storage test: machine_work.by_arg set value {key:"pre_by"}
function test:machine/by/loop
