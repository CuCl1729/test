#> test:status/passive
# @s = 対象。@macro status: ステータス名。バフより前に入る「受け身の取り分」P を
# #passive_p test.buff.work に入れる。
#   プレイヤー: test.status.gear.<名前>(装備ぶんのキャッシュ。test:status/gear が作り直す) +
#               test.job_bonus.<名前> + test.level_bonus.<名前>
#   それ以外:   test.status.base.<名前>(召喚時に控えた値。asset/enemy/summon 参照)
# 合計が32bitに収まったら 1、収まらなかったら 0 を返す(0のときの #passive_p は使わない)。
# 公開用の実効値は test:status/compose、参照値は test:buff/actor/reference がこれを土台に作る

scoreboard players set #passive_p test.buff.work 0
$execute unless entity @s[type=player] run scoreboard players operation #passive_p test.buff.work = @s test.status.base.$(status)
execute unless entity @s[type=player] run return 1

# 3つとも32bitなので += で直に足すと折り返す(装備 2147483647 + 職業 1 が INT_MIN になっていた)。
# スコアに合計を作らず、3項そのまま compute の整数加算へ渡して一度だけ範囲検査する(式の核は使わない)
data modify storage test: buff_math.arg set value {a:0,b:0,c:0}
$execute store result storage test: buff_math.arg.a int 1 run scoreboard players get @s test.status.gear.$(status)
$execute store result storage test: buff_math.arg.b int 1 run scoreboard players get @s test.job_bonus.$(status)
$execute store result storage test: buff_math.arg.c int 1 run scoreboard players get @s test.level_bonus.$(status)
function test:buff/math/add3 with storage test: buff_math.arg
execute if score #math_ok test.buff.work matches 0 run return 0

scoreboard players operation #passive_p test.buff.work = #math_sum test.buff.work
return 1
