#> test:equip/drop/roll
# @macro id/chance: 装備idと落ちる確率(%)。当たれば(rng のキー equip_drop)、battle.temporary.equip_hits に足す

execute store result score #equip_drop_roll test.temporary run function test:rng/roll {key:"equip_drop",min:1,max:100}
$execute unless score #equip_drop_roll test.temporary matches ..$(chance) run return 0

$data modify storage test: battle.temporary.equip_hits append value {id:"$(id)"}
