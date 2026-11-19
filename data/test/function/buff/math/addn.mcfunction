#> test:buff/math/addn
# 内部。@macro values: 32bitの整数のリスト(呼ぶ側が storage test: buff_math.arg.values に作る)。
# add3 と同じ約束で、合計を #math_sum test.buff.work、収まったかを #math_ok test.buff.work に入れる
# (#math_ok が 0 のときの #math_sum は使わない。和が 0 でも成功なので、結果と成否は別に見る)。
# compute の整数加算は途中を64bitで持ち最後の和だけ検査するので、途中で範囲を出ても折り返さない
$execute store success score #math_ok test.buff.work store result score #math_sum test.buff.work run compute default integer {type:"minecraft:add",inputs:$(values)}
