#> test:magic/combo/behavior/emit
# @s = 一定間隔の発生源(設置物・飛んでいる弾・持ち主に付いて回る印。at @s)。
# その位置で次の段の複製を1つ始める。発生源は消えない(回数が尽きるまで繰り返す)。
# どの形態の後ろに「一定間隔」を付けられるかは、組み合わせの表のつなぎの行が決めている
function test:magic/periodic/emit
