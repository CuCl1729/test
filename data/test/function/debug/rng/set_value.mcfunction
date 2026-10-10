#> test:debug/rng/set_value
# @macro key/value: 抽選のキーと、毎回返させる値(範囲外の値もそのまま返すので、意図した範囲で指定すること)

$data modify storage test: debug.rng.$(key).mode set value "value"
$data modify storage test: debug.rng.$(key).value set value $(value)

$function test:debug/menu/done {msg:"$(key) を値 $(value) に固定しました"}
