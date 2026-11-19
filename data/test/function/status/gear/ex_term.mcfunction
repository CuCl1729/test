#> test:status/gear/ex_term
# 内部。@macro i: 参照の通し番号 / v: 参照値(元の部品そのまま) / c: 係数。
# 同じ参照に複数の項が付く(参照の書き込みは同じ値なので何度でも良い)
$data modify storage test: buff_eval.arg.refs.r$(i) set value $(v)
$data modify storage test: buff_eval.arg.terms append value {stat:"r$(i)",percent:$(c)}
