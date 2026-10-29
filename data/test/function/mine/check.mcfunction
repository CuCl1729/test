#> test:mine/check
# @macro id: 鉱山のid。2つのマップ(test:action・test:turn)の同じ座標の鉱山を、それぞれ調べる(状態はマップごとに別)

$data modify storage test: mine_work.area set from storage test: asset.mine.$(id).area
$data modify storage test: mine_work.area.id set value "$(id)"
data modify storage test: mine_work.area.dim set value "action"
function test:mine/check_area with storage test: mine_work.area
data modify storage test: mine_work.area.dim set value "turn"
function test:mine/check_area with storage test: mine_work.area
