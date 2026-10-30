#> test:machine/smelt/hit
# @macro material/count/count_stage: 選ばれた主産物の行(ほかのキーも渡ってくるが使わない)。
# 個数 = count + count_stage × 段階 の素材を、出すもの(machine_work.drop)に足す

scoreboard players set #main_hit test.temporary 1
$scoreboard players set #machine_give_count test.temporary $(count)
$scoreboard players set #main_t test.temporary $(count_stage)
scoreboard players operation #main_t test.temporary *= #ore_stage test.temporary
scoreboard players operation #machine_give_count test.temporary += #main_t test.temporary
$function test:machine/give_material {id:"$(material)"}

data modify storage test: machine_work.log set value {kind:"",rare:0,stage:0,roll:0,total:0,count:0}
$data modify storage test: machine_work.log.material set value "$(material)"
data modify storage test: machine_work.log.kind set from storage test: machine_work.ore.kind
data modify storage test: machine_work.log.rare set from storage test: machine_work.ore.rare
data modify storage test: machine_work.log.stage set from storage test: machine_work.ore.stage
execute store result storage test: machine_work.log.roll int 1 run scoreboard players get #main_roll test.temporary
execute store result storage test: machine_work.log.total int 1 run scoreboard players get #main_total test.temporary
execute store result storage test: machine_work.log.count int 1 run scoreboard players get #machine_give_count test.temporary
function test:machine/smelt/log with storage test: machine_work.log
return 1
