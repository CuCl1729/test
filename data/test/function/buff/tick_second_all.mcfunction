#> test:buff/tick_second_all
# 1秒に1回、test:tick から呼ばれる。バフの継続時間を1秒ぶん進める
#
# ターン制のマップ(test:turn とその戦闘用アリーナ test:arena)では時間経過で進めない。
# そちらは保持者の手番終了時に10秒ぶん進める(test:battle/turn_end 参照)。
# status/regene/ が毎秒の自動回復を止めているのと同じ考え方
#
# @e は実行中のディメンションしか見ないため、プレイヤー以外はディメンションごとに走査する
# (@a はディメンションを問わず全員を拾うので、そちらは除外条件だけ書けばよい)
#
# 「unless dimension」が見るのは@sの居場所ではなく“実行中の”ディメンションなので、
# asの後に必ずat @sを挟むこと。これが無いとtest:tickの実行位置(オーバーワールド)のまま判定され、
# 条件が常に真になってアリーナ内でも毎秒減ってしまう

execute as @a[tag=buffed] at @s unless dimension test:turn unless dimension test:arena run function test:buff/tick_second
execute in minecraft:overworld as @e[tag=buffed,type=!player] run function test:buff/tick_second
execute in test:action as @e[tag=buffed,type=!player] run function test:buff/tick_second
