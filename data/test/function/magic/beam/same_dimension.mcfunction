#> test:magic/beam/same_dimension
# @s = ビームを出しているプレイヤー。@macro beam_dimension: register がそのビームを唱えたときに刻んだ次元。
# 今いる実際の次元と違えば0を返す(ポータル等でワールドを跨いでも古いビームが残るバグの対策)
$execute if dimension $(beam_dimension) run return 1
return 0
