#> test:debug/reset_mine
# @s = プレイヤー。今いるマップ(test:action / test:turn)で、範囲の中にいる鉱山を、リセット間隔を無視して今すぐ元に戻す

data modify storage test: mine_work.here set value {dim:""}
execute at @s if dimension test:action run data modify storage test: mine_work.here.dim set value "action"
execute at @s if dimension test:turn run data modify storage test: mine_work.here.dim set value "turn"
execute if data storage test: mine_work.here{dim:""} run return run tellraw @s [{text:"鉱山の中にいない",color:gray}]

scoreboard players set #mine_found test.temporary 0
data modify storage test: mine_work.debug_queue set from storage test: asset.mine_ids
function test:debug/reset_mine_loop
execute if score #mine_found test.temporary matches 0 run tellraw @s [{text:"鉱山の中にいない",color:gray}]
