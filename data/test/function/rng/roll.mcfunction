#> test:rng/roll
# @macro key/min/max: 抽選の名前(init/asset/debug/rngで宣言したもの)と範囲。抽選結果を戻り値で返すので、
# 呼び出し側は`execute store result <対象> run function test:rng/roll {...}`で受け取る。
# 乱数はすべてここを通す(デバッグメニューから結果の固定・シードでの再現ができるようにするため)
#
# - storage test: debug.rng.<key>.mode が min/max/value なら、乱数を引かずにその値を返す
# - それ以外は名前付きの乱数列test:<key>から引く。`random reset test:<key> <seed>`でこの列だけ巻き戻せる

$execute if data storage test: debug.rng.$(key){mode:"min"} run return $(min)
$execute if data storage test: debug.rng.$(key){mode:"max"} run return $(max)
$execute if data storage test: debug.rng.$(key){mode:"value"} run return run data get storage test: debug.rng.$(key).value
$return run random value $(min)..$(max) test:$(key)
