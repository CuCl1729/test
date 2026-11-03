#> test:magic/crafter/stage_assemble
# @s = クラフター本体。registry_work.stages を1つの魔法にまとめる: 1段目の status + chain(2段目以降)。
# 費用は全段とつなぎの合計。最後の段が設置(後ろにつなぎが無い)なら不正
function test:asset/magic/reset
execute if data storage test: registry_work.stages[0] run data modify storage test: magic.loot.status set from storage test: registry_work.stages[0].status
data modify storage test: registry_work.chain_src set from storage test: registry_work.stages
data remove storage test: registry_work.chain_src[0]
function test:magic/crafter/stage_chain_loop
scoreboard players operation #cost test.temporary = #cost_total test.temporary

execute if data storage test: registry_work.stages[-1].status{magic_type:"place"} run scoreboard players set #stage_invalid test.temporary 1
execute if score #stage_invalid test.temporary matches 1 run data modify storage test: magic.loot.invalid set value 1b
