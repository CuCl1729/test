#> test:debug/check_veins_area
# @macro x1/y1/z1/dx/dy/dz: 鉱山の範囲。両方のマップの、範囲の中のアマスタを1体ずつ、もう片方と比べる

$execute in test:action positioned $(x1) $(y1) $(z1) as @e[type=armor_stand,tag=mine_vein,dx=$(dx),dy=$(dy),dz=$(dz)] run function test:debug/check_veins_one {dim:"action",other:"turn"}
$execute in test:turn positioned $(x1) $(y1) $(z1) as @e[type=armor_stand,tag=mine_vein,dx=$(dx),dy=$(dy),dz=$(dz)] run function test:debug/check_veins_one {dim:"turn",other:"action"}
