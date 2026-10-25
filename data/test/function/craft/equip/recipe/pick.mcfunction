#> test:craft/equip/recipe/pick
# @macro head/chest/legs/feet/accessory: その素材で作れる部位ごとの装備id。型紙の部位はstorage test: loot.equip_partから読む。
# 型紙の部位に対応する装備を test:asset/equip/apply で作る(素材ごとのレシピは対応表を渡すだけにする)

$execute if data storage test: {loot:{equip_part:"head"}} run return run function test:asset/equip/apply {id:"$(head)"}
$execute if data storage test: {loot:{equip_part:"chest"}} run return run function test:asset/equip/apply {id:"$(chest)"}
$execute if data storage test: {loot:{equip_part:"legs"}} run return run function test:asset/equip/apply {id:"$(legs)"}
$execute if data storage test: {loot:{equip_part:"feet"}} run return run function test:asset/equip/apply {id:"$(feet)"}
$execute if data storage test: {loot:{equip_part:"accessory"}} run return run function test:asset/equip/apply {id:"$(accessory)"}
