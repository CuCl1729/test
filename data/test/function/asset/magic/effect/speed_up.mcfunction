# 加速のバフを付与する効果。仕組みはatk_upと同じで、素材の個数ぶん3スタックまで重ねがけできる
scoreboard players set #speed_up_apply test.temporary 0
$execute unless score #speed_up_stack test.temporary matches $(max_stacks).. run scoreboard players set #speed_up_apply test.temporary 1

execute if score #speed_up_apply test.temporary matches 1 run scoreboard players add #speed_up_stack test.temporary 1
$execute if score #speed_up_apply test.temporary matches 1 run scoreboard players add #cost test.temporary $(cost)

execute unless data storage test: magic.loot.status.buff[{id:"speed_up"}] run data modify storage test: magic.loot.status.buff append value {id:"speed_up",stacks:1}
execute store result storage test: magic.loot.status.buff[{id:"speed_up"}].stacks int 1 run scoreboard players get #speed_up_stack test.temporary
