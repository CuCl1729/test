#> test:debug/rng/seed
# @macro key/seed: 抽選の乱数列test:<key>をこのシードで巻き戻し、[再現]用に覚えておく。
# この後の抽選は毎回同じ並びになる(固定中の抽選は乱数を引かないので、固定を解いてから使う)

$random reset test:$(key) $(seed)
$data modify storage test: debug.rng.$(key).key set value "$(key)"
$data modify storage test: debug.rng.$(key).seed set value $(seed)

$function test:debug/menu/done {msg:"$(key) の乱数列をシード $(seed) で巻き戻しました"}
