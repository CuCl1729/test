#> test:farm/attack_match
# @s = 魔法作物。攻撃した人(attack.player)が gather_work.uuid と同じなら、データを消して抜く

data modify storage test: gather_work.cmp set from storage test: gather_work.uuid
execute store success score #gather_diff test.temporary run data modify storage test: gather_work.cmp set from entity @s attack.player
execute if score #gather_diff test.temporary matches 1 run return 0
data remove entity @s attack
function test:farm/pop with entity @s data.crop
