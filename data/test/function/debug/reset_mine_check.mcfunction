#> test:debug/reset_mine_check
# @s = プレイヤー。@macro id/dim: 鉱山のidと今いるマップ。範囲の中にいれば元に戻す

$data modify storage test: mine_work.here_area set from storage test: asset.mine.$(id).area
$data modify storage test: mine_work.here_area.id set value "$(id)"
$data modify storage test: mine_work.here_area.dim set value "$(dim)"
function test:debug/reset_mine_area with storage test: mine_work.here_area
