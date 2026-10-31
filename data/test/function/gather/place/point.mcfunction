#> test:gather/place/point
# @macro id: ポイントのid。test:action と test:turn のそれぞれで置く

$data modify storage test: gather_work.p set from storage test: asset.gather_point.$(id)
$data modify storage test: gather_work.p.id set value "$(id)"
data modify storage test: gather_work.p.dim set value "action"
function test:gather/place/try with storage test: gather_work.p
data modify storage test: gather_work.p.dim set value "turn"
function test:gather/place/try with storage test: gather_work.p
