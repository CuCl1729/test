#> test:mine/token/convert_one
# @s = プレイヤー。@macro id: 鉱脈のid。その鉱脈の目印を全部消し、消した個数ぶん原石のレア度を抽選して
# (rng のキー ore_rarity。重みは asset.vein.<id>.weights)、レア度ごとにまとめて原石を渡す

$execute unless data storage test: asset.vein.$(id) run return run function test:debug/log {msg:"目印: 鉱脈「$(id)」の定義がありません"}

scoreboard players set #token_count test.temporary 0
$execute store result score #token_count test.temporary run clear @s *[custom_data~{test:{ore_token:"$(id)"}}]
execute if score #token_count test.temporary matches ..0 run return 0

$data modify storage test: mine_work.mine set from storage test: asset.vein.$(id)
scoreboard players set #ore_r1 test.temporary 0
scoreboard players set #ore_r2 test.temporary 0
scoreboard players set #ore_r3 test.temporary 0
scoreboard players set #ore_r4 test.temporary 0
scoreboard players set #ore_r5 test.temporary 0
function test:mine/token/roll_loop

data modify storage test: mine_work.give set value {id:"",rare:0,count:0}
data modify storage test: mine_work.give.id set from storage test: mine_work.mine.ore
execute if score #ore_r1 test.temporary matches 1.. run function test:mine/token/give_rare {rare:1}
execute if score #ore_r2 test.temporary matches 1.. run function test:mine/token/give_rare {rare:2}
execute if score #ore_r3 test.temporary matches 1.. run function test:mine/token/give_rare {rare:3}
execute if score #ore_r4 test.temporary matches 1.. run function test:mine/token/give_rare {rare:4}
execute if score #ore_r5 test.temporary matches 1.. run function test:mine/token/give_rare {rare:5}

$data modify storage test: mine_work.log set value {id:"$(id)"}
execute store result storage test: mine_work.log.r1 int 1 run scoreboard players get #ore_r1 test.temporary
execute store result storage test: mine_work.log.r2 int 1 run scoreboard players get #ore_r2 test.temporary
execute store result storage test: mine_work.log.r3 int 1 run scoreboard players get #ore_r3 test.temporary
execute store result storage test: mine_work.log.r4 int 1 run scoreboard players get #ore_r4 test.temporary
execute store result storage test: mine_work.log.r5 int 1 run scoreboard players get #ore_r5 test.temporary
function test:mine/token/log with storage test: mine_work.log
