#> test:buff/math/add3
# 内部。@macro a/b/c: 32bitの整数(呼ぶ側が storage test: buff_math.arg に作る)。
# a+b+c を #math_sum test.buff.work に入れ、和が32bitに収まったかを #math_ok test.buff.work に立てる
# (#math_ok が 0 のときの #math_sum は使わない。和が 0 でも成功なので、結果と成否は別に見る)。
# 2項の足し算は c に 0 を渡す(和も範囲検査も変わらない)。
# compute の整数加算は途中を64bitで持ち最後の和だけ検査するので、2147483647+1-1 は折り返さず成功する
$execute store success score #math_ok test.buff.work store result score #math_sum test.buff.work run compute default integer {type:"minecraft:add",inputs:[$(a),$(b),$(c)]}
