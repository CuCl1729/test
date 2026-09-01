#> test:buff/step_interval_advance
# #next が #elapsed を追い越すまで interval ぶん進める。
# こうしておくと1ステップで大きく時間が飛んでも(ターン制の10秒など)発火は1回で済み、
# かつ次の発火時刻がずれていかない

execute unless score #next test.buff.work <= #elapsed test.buff.work run return 0

scoreboard players operation #next test.buff.work += #interval test.buff.work

function test:buff/step_interval_advance
