#> test:status/compose
# @s = 対象。@macro status: ステータス名。受け身の取り分とバフの合計から公開用の実効値を作る。
#   test.status.<名前> = floor((P + A) × (10000 + M) / 10000)
#     P = プレイヤー: test.status.gear.<名前>(装備ぶん。test:status/gear が作る) + test.job_bonus + test.level_bonus
#         それ以外:   test.status.base.<名前>(召喚時の値。asset/enemy/summon 参照)
#     A = test.buff.<名前>      バフの加算の合計
#     M = test.buff.m.<名前>    バフの乗率の合計(×10000。既定は0で、昔どおり A をそのまま足すのと同じ)
# 受け身の取り分はすべてバフより前に入る。参照値(P + test.buff.flat)は test:buff/actor/reference が別に作る。
# ステータス全体への0クランプはしない(0で止めるのはバフ1行ごと)。
# 範囲に収まらなかったら(受け身の取り分の合計も含めて) 0 を返し、test.status.<名前> は前の値のまま残す

$execute store result score #compose_p_ok test.buff.work run function test:status/passive {status:"$(status)"}
execute if score #compose_p_ok test.buff.work matches 0 run return 0

# P と A と M を素のまま控える(どちらの道でも使う。スコアが無いときは 0)
data modify storage test: buff_math.arg set value {a:0,b:0,c:0}
execute store result storage test: buff_math.arg.a int 1 run scoreboard players get #passive_p test.buff.work
$execute store result storage test: buff_math.arg.b int 1 run scoreboard players get @s test.buff.$(status)
$execute store result score #compose_m test.buff.work run scoreboard players get @s test.buff.m.$(status)

# M=0 なら floor((P+A)×10000/10000) = P+A。重い核を通さず compute の整数加算一回で足して範囲も見る
execute if score #compose_m test.buff.work matches 0 run function test:buff/math/add3 with storage test: buff_math.arg
execute if score #compose_m test.buff.work matches 0 if score #math_ok test.buff.work matches 0 run return 0
$execute if score #compose_m test.buff.work matches 0 store result score @s test.status.$(status) run scoreboard players get #math_sum test.buff.work
execute if score #compose_m test.buff.work matches 0 run return 1

# M≠0: P+A も 10000+M もスコアに作らず、2つのrefへ各2項で分子を広いまま持つ(test:buff/layers/emit_one と同じ形)
data modify storage test: buff_eval.arg set value {terms:[{stat:"p",percent:10000},{stat:"a",percent:10000},{stat:"p",percent:0},{stat:"a",percent:0}],flat:0,refs:{p:0,a:0}}
data modify storage test: buff_eval.arg.refs.p set from storage test: buff_math.arg.a
data modify storage test: buff_eval.arg.refs.a set from storage test: buff_math.arg.b
execute store result storage test: buff_eval.arg.terms[2].percent int 1 run scoreboard players get #compose_m test.buff.work
execute store result storage test: buff_eval.arg.terms[3].percent int 1 run scoreboard players get #compose_m test.buff.work
function test:buff/eval/signed
execute if data storage test: buff_eval.result{ok:0b} run return 0

$execute store result score @s test.status.$(status) run data get storage test: buff_eval.result.value
return 1
