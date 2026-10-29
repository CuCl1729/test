#> test:mine/place_one
# @macro id/x/y/z/dim: 構造物のidと置く座標、マップ(action / turn)

$execute in test:$(dim) run place template $(id) $(x) $(y) $(z)
