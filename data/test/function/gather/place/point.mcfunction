#> test:gather/place/point
# @macro id: ポイントのid。定義(gather_world.point.<id> + 採取物の見た目)を作り、test:action と test:turn のそれぞれで置く。
# 採取物がシートから消えていれば置かない
$data modify storage test: gather_work.p set from storage test: gather_world.point.$(id)
function test:gather/place/def with storage test: gather_work.p
execute unless data storage test: gather_work.p.block run return 0
$data modify storage test: gather_work.p.id set value "$(id)"
data modify storage test: gather_work.p.dim set value "action"
function test:gather/place/try with storage test: gather_work.p
data modify storage test: gather_work.p.dim set value "turn"
function test:gather/place/try with storage test: gather_work.p
