# 跳躍のバフを付与する効果。仕組みはatk_upと同じで、素材の個数ぶん3スタックまで重ねがけできる
scoreboard players set #jump_up_apply test.temporary 0
$execute unless score #jump_up_stack test.temporary matches $(max_stacks).. run scoreboard players set #jump_up_apply test.temporary 1

execute if score #jump_up_apply test.temporary matches 1 run scoreboard players add #jump_up_stack test.temporary 1
$execute if score #jump_up_apply test.temporary matches 1 run scoreboard players add #cost test.temporary $(cost)

execute unless data storage test: magic.loot.status.buff[{id:"jump_up"}] run data modify storage test: magic.loot.status.buff append value {id:"jump_up",stacks:1}
execute store result storage test: magic.loot.status.buff[{id:"jump_up"}].stacks int 1 run scoreboard players get #jump_up_stack test.temporary
