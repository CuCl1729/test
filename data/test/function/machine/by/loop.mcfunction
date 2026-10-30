#> test:machine/by/loop
# machine_work.by(副産物の行 [{material, chance, chance_rare, chance_stage?, count}])を1行ずつ判定する。
# 確率(%) = chance + chance_rare × (レア度−1) + chance_stage × 段階(100で頭打ち)。1..100 を引き(rng のキーは
# machine_work.by_arg.key)、確率以下なら count 個を出すもの(machine_work.drop)に足す。前処理の行は chance_stage を持たない(0)

execute unless data storage test: machine_work.by[0] run return 0

execute store result score #by_c test.temporary run data get storage test: machine_work.by[0].chance
execute store result score #by_t test.temporary run data get storage test: machine_work.by[0].chance_rare
scoreboard players operation #by_t test.temporary *= #ore_rare1 test.temporary
scoreboard players operation #by_c test.temporary += #by_t test.temporary
scoreboard players set #by_t test.temporary 0
execute if data storage test: machine_work.by[0].chance_stage store result score #by_t test.temporary run data get storage test: machine_work.by[0].chance_stage
scoreboard players operation #by_t test.temporary *= #ore_stage test.temporary
scoreboard players operation #by_c test.temporary += #by_t test.temporary
# 筐体の副産物の確率(machine/run が #machine_by_bonus に入れる)
scoreboard players operation #by_c test.temporary += #machine_by_bonus test.temporary
execute if score #by_c test.temporary matches 101.. run scoreboard players set #by_c test.temporary 100

function test:machine/by/roll with storage test: machine_work.by_arg
scoreboard players set #by_hit test.temporary 0
execute if score #by_roll test.temporary <= #by_c test.temporary run scoreboard players set #by_hit test.temporary 1
execute if score #by_hit test.temporary matches 1 run function test:machine/by/hit with storage test: machine_work.by[0]
function test:machine/by/log_prepare

data remove storage test: machine_work.by[0]
function test:machine/by/loop
