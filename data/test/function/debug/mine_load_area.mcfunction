#> test:debug/mine_load_area
# @macro mode/x1/z1/x2/z2: add / remove と、鉱山の範囲の角。両方のマップでその範囲を forceload する(またはやめる)

$execute in test:action run forceload $(mode) $(x1) $(z1) $(x2) $(z2)
$execute in test:turn run forceload $(mode) $(x1) $(z1) $(x2) $(z2)
