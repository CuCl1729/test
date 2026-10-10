#> test:debug/rng/set
# @macro key/mode: 抽選のキーと固定の仕方(random=固定しない / min / max)。test:rng/rollがこの設定を読む

$data remove storage test: debug.rng.$(key).value
$data modify storage test: debug.rng.$(key).mode set value "$(mode)"
$execute if data storage test: debug.rng.$(key){mode:"random"} run data remove storage test: debug.rng.$(key).mode

$function test:debug/menu/done {msg:"$(key) を $(mode) にしました"}
