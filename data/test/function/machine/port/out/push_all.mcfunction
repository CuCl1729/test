#> test:machine/port/out/push_all
# @s = 機械のマーカー(実行位置は核の中心)。搬出口ごとに、中身を向いている先(送り先)の入れ物へ送る。
# 送り先が入れ物でなければ(または、いっぱいなら)、搬出口の中に残る。1つの搬出口から1秒に送るのは16個まで

data modify storage test: machine_work.push_queue set from storage test: machine_work.outputs
function test:machine/port/out/push_loop
