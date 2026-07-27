#> test:battle/goto_safe_area
# 呼び出し元で in test:turn 済み。$(x)(y)(z)=戦闘が始まった地点(セーフエリア検索の基準点)

$execute positioned $(x) $(y) $(z) run tp @s @e[tag=safe_area,sort=nearest,limit=1]