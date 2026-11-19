#> test:buff/eval/term_one
# @macro stat/percent
# data getの失敗は本物の0と区別できないため、refsの存在を先に見る。無ければ#be_errを立てて抜ける
$execute unless data storage test: buff_eval.work.refs.$(stat) run scoreboard players set #be_err test.buff.work 1
$execute unless data storage test: buff_eval.work.refs.$(stat) run return 0

# 積が0の項は加算器に何も足さないので、2回のsplitと25積をまとめて省く。
# missing_referenceを落とさないため、この短絡は上の存在チェックより後ろに置く
$scoreboard players set #be_t test.buff.work $(percent)
execute if score #be_t test.buff.work matches 0 run return 0

$execute store result score #be_v test.buff.work run data get storage test: buff_eval.work.refs.$(stat)
execute if score #be_v test.buff.work matches 0 run return 0

function test:buff/eval/split
scoreboard players operation #be_r0 test.buff.work = #be_d0 test.buff.work
scoreboard players operation #be_r1 test.buff.work = #be_d1 test.buff.work
scoreboard players operation #be_r2 test.buff.work = #be_d2 test.buff.work
scoreboard players operation #be_r3 test.buff.work = #be_d3 test.buff.work
scoreboard players operation #be_r4 test.buff.work = #be_d4 test.buff.work

# refが負のときだけ桁に符号を乗せる。percentは非負なので積がそのまま符号付きになる
execute if score #be_s test.buff.work matches -1 run scoreboard players operation #be_r0 test.buff.work *= #be_s test.buff.work
execute if score #be_s test.buff.work matches -1 run scoreboard players operation #be_r1 test.buff.work *= #be_s test.buff.work
execute if score #be_s test.buff.work matches -1 run scoreboard players operation #be_r2 test.buff.work *= #be_s test.buff.work
execute if score #be_s test.buff.work matches -1 run scoreboard players operation #be_r3 test.buff.work *= #be_s test.buff.work
execute if score #be_s test.buff.work matches -1 run scoreboard players operation #be_r4 test.buff.work *= #be_s test.buff.work

$scoreboard players set #be_v test.buff.work $(percent)
function test:buff/eval/split
scoreboard players operation #be_p0 test.buff.work = #be_d0 test.buff.work
scoreboard players operation #be_p1 test.buff.work = #be_d1 test.buff.work
scoreboard players operation #be_p2 test.buff.work = #be_d2 test.buff.work
scoreboard players operation #be_p3 test.buff.work = #be_d3 test.buff.work
scoreboard players operation #be_p4 test.buff.work = #be_d4 test.buff.work

# percentが負のときだけ桁に符号を乗せる(signed専用。公開経路ではpercentは非負なので無処理)
execute if score #be_s test.buff.work matches -1 run scoreboard players operation #be_p0 test.buff.work *= #be_s test.buff.work
execute if score #be_s test.buff.work matches -1 run scoreboard players operation #be_p1 test.buff.work *= #be_s test.buff.work
execute if score #be_s test.buff.work matches -1 run scoreboard players operation #be_p2 test.buff.work *= #be_s test.buff.work
execute if score #be_s test.buff.work matches -1 run scoreboard players operation #be_p3 test.buff.work *= #be_s test.buff.work
execute if score #be_s test.buff.work matches -1 run scoreboard players operation #be_p4 test.buff.work *= #be_s test.buff.work

# 25個の乗算加算 #be_a(i+j) += #be_r(i)*#be_p(j)。意図的に展開して書く
scoreboard players operation #be_t test.buff.work = #be_r0 test.buff.work
scoreboard players operation #be_t test.buff.work *= #be_p0 test.buff.work
scoreboard players operation #be_a0 test.buff.work += #be_t test.buff.work

scoreboard players operation #be_t test.buff.work = #be_r0 test.buff.work
scoreboard players operation #be_t test.buff.work *= #be_p1 test.buff.work
scoreboard players operation #be_a1 test.buff.work += #be_t test.buff.work

scoreboard players operation #be_t test.buff.work = #be_r0 test.buff.work
scoreboard players operation #be_t test.buff.work *= #be_p2 test.buff.work
scoreboard players operation #be_a2 test.buff.work += #be_t test.buff.work

scoreboard players operation #be_t test.buff.work = #be_r0 test.buff.work
scoreboard players operation #be_t test.buff.work *= #be_p3 test.buff.work
scoreboard players operation #be_a3 test.buff.work += #be_t test.buff.work

scoreboard players operation #be_t test.buff.work = #be_r0 test.buff.work
scoreboard players operation #be_t test.buff.work *= #be_p4 test.buff.work
scoreboard players operation #be_a4 test.buff.work += #be_t test.buff.work

scoreboard players operation #be_t test.buff.work = #be_r1 test.buff.work
scoreboard players operation #be_t test.buff.work *= #be_p0 test.buff.work
scoreboard players operation #be_a1 test.buff.work += #be_t test.buff.work

scoreboard players operation #be_t test.buff.work = #be_r1 test.buff.work
scoreboard players operation #be_t test.buff.work *= #be_p1 test.buff.work
scoreboard players operation #be_a2 test.buff.work += #be_t test.buff.work

scoreboard players operation #be_t test.buff.work = #be_r1 test.buff.work
scoreboard players operation #be_t test.buff.work *= #be_p2 test.buff.work
scoreboard players operation #be_a3 test.buff.work += #be_t test.buff.work

scoreboard players operation #be_t test.buff.work = #be_r1 test.buff.work
scoreboard players operation #be_t test.buff.work *= #be_p3 test.buff.work
scoreboard players operation #be_a4 test.buff.work += #be_t test.buff.work

scoreboard players operation #be_t test.buff.work = #be_r1 test.buff.work
scoreboard players operation #be_t test.buff.work *= #be_p4 test.buff.work
scoreboard players operation #be_a5 test.buff.work += #be_t test.buff.work

scoreboard players operation #be_t test.buff.work = #be_r2 test.buff.work
scoreboard players operation #be_t test.buff.work *= #be_p0 test.buff.work
scoreboard players operation #be_a2 test.buff.work += #be_t test.buff.work

scoreboard players operation #be_t test.buff.work = #be_r2 test.buff.work
scoreboard players operation #be_t test.buff.work *= #be_p1 test.buff.work
scoreboard players operation #be_a3 test.buff.work += #be_t test.buff.work

scoreboard players operation #be_t test.buff.work = #be_r2 test.buff.work
scoreboard players operation #be_t test.buff.work *= #be_p2 test.buff.work
scoreboard players operation #be_a4 test.buff.work += #be_t test.buff.work

scoreboard players operation #be_t test.buff.work = #be_r2 test.buff.work
scoreboard players operation #be_t test.buff.work *= #be_p3 test.buff.work
scoreboard players operation #be_a5 test.buff.work += #be_t test.buff.work

scoreboard players operation #be_t test.buff.work = #be_r2 test.buff.work
scoreboard players operation #be_t test.buff.work *= #be_p4 test.buff.work
scoreboard players operation #be_a6 test.buff.work += #be_t test.buff.work

scoreboard players operation #be_t test.buff.work = #be_r3 test.buff.work
scoreboard players operation #be_t test.buff.work *= #be_p0 test.buff.work
scoreboard players operation #be_a3 test.buff.work += #be_t test.buff.work

scoreboard players operation #be_t test.buff.work = #be_r3 test.buff.work
scoreboard players operation #be_t test.buff.work *= #be_p1 test.buff.work
scoreboard players operation #be_a4 test.buff.work += #be_t test.buff.work

scoreboard players operation #be_t test.buff.work = #be_r3 test.buff.work
scoreboard players operation #be_t test.buff.work *= #be_p2 test.buff.work
scoreboard players operation #be_a5 test.buff.work += #be_t test.buff.work

scoreboard players operation #be_t test.buff.work = #be_r3 test.buff.work
scoreboard players operation #be_t test.buff.work *= #be_p3 test.buff.work
scoreboard players operation #be_a6 test.buff.work += #be_t test.buff.work

scoreboard players operation #be_t test.buff.work = #be_r3 test.buff.work
scoreboard players operation #be_t test.buff.work *= #be_p4 test.buff.work
scoreboard players operation #be_a7 test.buff.work += #be_t test.buff.work

scoreboard players operation #be_t test.buff.work = #be_r4 test.buff.work
scoreboard players operation #be_t test.buff.work *= #be_p0 test.buff.work
scoreboard players operation #be_a4 test.buff.work += #be_t test.buff.work

scoreboard players operation #be_t test.buff.work = #be_r4 test.buff.work
scoreboard players operation #be_t test.buff.work *= #be_p1 test.buff.work
scoreboard players operation #be_a5 test.buff.work += #be_t test.buff.work

scoreboard players operation #be_t test.buff.work = #be_r4 test.buff.work
scoreboard players operation #be_t test.buff.work *= #be_p2 test.buff.work
scoreboard players operation #be_a6 test.buff.work += #be_t test.buff.work

scoreboard players operation #be_t test.buff.work = #be_r4 test.buff.work
scoreboard players operation #be_t test.buff.work *= #be_p3 test.buff.work
scoreboard players operation #be_a7 test.buff.work += #be_t test.buff.work

scoreboard players operation #be_t test.buff.work = #be_r4 test.buff.work
scoreboard players operation #be_t test.buff.work *= #be_p4 test.buff.work
scoreboard players operation #be_a8 test.buff.work += #be_t test.buff.work
