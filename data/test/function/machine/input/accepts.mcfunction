#> test:machine/input/accepts
# machine_work.items[0](入れ物の中の1スロット)を、この機械(machine_work.def)が受け付けるなら1、受け付けなければ0を返す。
# - 原石・加工途中の原石(custom_data.test.ore)だけ。目印(ore_token)は持ち物で原石に変わるものなので受け付けない
# - 精錬炉(smelt)は段階に関係なく全部
# - 前処理(pre)は stage がちょうど1つ前のものだけ(同じ機械に何度も通して段階を稼げないように)。原石は stage が無いか0

execute unless data storage test: machine_work.items[0].components."minecraft:custom_data".test.ore run return 0
execute if data storage test: machine_work.def{kind:"smelt"} run return 1

scoreboard players set #machine_s test.temporary 0
execute if data storage test: machine_work.items[0].components."minecraft:custom_data".test.ore.stage store result score #machine_s test.temporary run data get storage test: machine_work.items[0].components."minecraft:custom_data".test.ore.stage
execute store result score #machine_need test.temporary run data get storage test: machine_work.def.stage
scoreboard players remove #machine_need test.temporary 1
execute if score #machine_s test.temporary = #machine_need test.temporary run return 1
return 0
