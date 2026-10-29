#> test:item/material/roll_drop
# @macro id/min/max: 素材のidと個数の範囲。個数を抽選し(rng のキー material_drop)、1個以上なら material_hits に足す

scoreboard players set #material_drop test.temporary 0
$execute store result score #material_drop test.temporary run function test:rng/roll {key:"material_drop",min:$(min),max:$(max)}
execute if score #material_drop test.temporary matches ..0 run return 0

$data modify storage test: battle.temporary.material_hits append value {id:"$(id)",count:0}
execute store result storage test: battle.temporary.material_hits[-1].count int 1 run scoreboard players get #material_drop test.temporary
