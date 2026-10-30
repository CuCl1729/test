#> test:debug/check_veins_pair
# @macro dim/other/x/y/z/vein: debug_work.check。もう片方のマップの同じ位置にアマスタが無ければ「無い」行を出す。
# 鉱脈が違うときは、2回出ないよう action 側から見たときだけ「違う」行を出す

$execute in test:$(other) positioned $(x) $(y) $(z) align xyz unless entity @e[type=armor_stand,tag=mine_vein,distance=..0.5] run return run function test:debug/check_veins_missing with storage test: debug_work.check
execute unless data storage test: debug_work.check{dim:"action"} run return 0
$execute in test:$(other) positioned $(x) $(y) $(z) align xyz if entity @e[type=armor_stand,tag=mine_vein,distance=..0.5,nbt={data:{vein:"$(vein)"}}] run return 0
$execute in test:$(other) positioned $(x) $(y) $(z) align xyz as @e[type=armor_stand,tag=mine_vein,distance=..0.5,limit=1] run data modify storage test: debug_work.check.other_vein set from entity @s data.vein
function test:debug/check_veins_differ with storage test: debug_work.check
