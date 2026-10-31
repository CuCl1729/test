#> test:debug/farm_mature_one
# @s = 魔法作物。@macro id: 魔法作物のid(ほかのキーも渡ってくるが使わない)

$data modify storage test: farm_work.def set from storage test: asset.magic_crop.$(id)
data modify entity @s data.crop.stage set from storage test: farm_work.def.last
function test:farm/look with entity @s data.crop
