# 毒のデバフを付与する効果。仕組みはatk_upと同じで、素材の個数ぶん3スタックまで重ねがけできる
scoreboard players set #poison_apply test.temporary 0
execute unless score #poison_stack test.temporary matches 3.. run scoreboard players set #poison_apply test.temporary 1

execute if score #poison_apply test.temporary matches 1 run scoreboard players add #poison_stack test.temporary 1
execute if score #poison_apply test.temporary matches 1 run scoreboard players add #cost test.temporary 90

execute unless data storage test: magic.loot.status.buff[{id:"poison"}] run data modify storage test: magic.loot.status.buff append value {id:"poison",stacks:1}
execute store result storage test: magic.loot.status.buff[{id:"poison"}].stacks int 1 run scoreboard players get #poison_stack test.temporary
