#> test:consumable/effect/revive
# @s = 使う人。@macro percent: 戻すHP(最大HPの何%) / radius: リアルタイムで届く距離。
# 倒れた味方を1人起こす(test:status/revive_pick → test:status/revive)。相手がいなければ何もしない
# (使う前に test:consumable/can_use で確かめるので、普通はここで外れない)

$execute store result score #revive_found test.temporary run function test:status/revive_pick {radius:$(radius)}
$execute if score #revive_found test.temporary matches 1 as @a[tag=revive_target,limit=1] run function test:status/revive {percent:$(percent)}
tag @a remove revive_target
