#> test:farm/harvest
# @s = 魔法作物を右クリックしたプレイヤー(test:gather/interact から)。対象は tag=gather_target の魔法作物

data modify storage test: farm_work.t set from entity @n[type=interaction,tag=gather_target] data.crop
function test:farm/harvest_with with storage test: farm_work.t
