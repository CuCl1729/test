#> test:buff/stat/remove
# @s = バフ保持者。@macro stat: ステータス名 / amount: 減らす量(内部の100倍値)
# test:buff/stat/add で足したぶんを戻す(終了イベントから呼ぶ)

$scoreboard players remove @s test.buff.$(stat) $(amount)
$function test:status/recalc {status:"$(stat)",op:"remove",amount:$(amount)}
