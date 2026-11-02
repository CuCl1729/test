#> test:gather/place/check
# @s = 採取ポイント(interaction)。@macro point: ポイントのid(ほかのキーも渡ってくるが使わない)。
# 記録に無いか、定義(採取物・見た目・座標)が置いたときと変わっていれば片付ける(次の place/all で置き直される)
$execute unless data storage test: gather_world.point.$(point) run return run function test:gather/place/remove
$data modify storage test: gather_work.p set from storage test: gather_world.point.$(point)
function test:gather/place/def with storage test: gather_work.p
execute store success score #gather_diff test.temporary run data modify storage test: gather_work.p set from entity @s data.gather.def
execute if score #gather_diff test.temporary matches 1 run function test:gather/place/remove
