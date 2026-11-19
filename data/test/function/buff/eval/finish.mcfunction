#> test:buff/eval/finish
# flatの加算から確定値の書き出しまで(手順4-10)。resultはここで一度だけ書く

# flatは生の値のまま加えると桁オーバーの恐れがあるため、桁に分けてa2..a6(除算前の列)へ足す
scoreboard players operation #be_v test.buff.work = #be_flat test.buff.work
function test:buff/eval/split

# flatが負のときだけ桁に符号を乗せる(signed専用。公開経路ではflatは非負)
execute if score #be_s test.buff.work matches -1 run scoreboard players operation #be_d0 test.buff.work *= #be_s test.buff.work
execute if score #be_s test.buff.work matches -1 run scoreboard players operation #be_d1 test.buff.work *= #be_s test.buff.work
execute if score #be_s test.buff.work matches -1 run scoreboard players operation #be_d2 test.buff.work *= #be_s test.buff.work
execute if score #be_s test.buff.work matches -1 run scoreboard players operation #be_d3 test.buff.work *= #be_s test.buff.work
execute if score #be_s test.buff.work matches -1 run scoreboard players operation #be_d4 test.buff.work *= #be_s test.buff.work

scoreboard players operation #be_a2 test.buff.work += #be_d0 test.buff.work
scoreboard players operation #be_a3 test.buff.work += #be_d1 test.buff.work
scoreboard players operation #be_a4 test.buff.work += #be_d2 test.buff.work
scoreboard players operation #be_a5 test.buff.work += #be_d3 test.buff.work
scoreboard players operation #be_a6 test.buff.work += #be_d4 test.buff.work

function test:buff/eval/propagate

# 10000で割るのは下2桁(a0,a1)を捨てるのと同じ。余りは非負なので残りはそのままfloor(.../10000)
scoreboard players set #be_a0 test.buff.work 0
scoreboard players set #be_a1 test.buff.work 0

# a12が負なら小計全体が負。参照ごとではなく小計全体を0にクランプする(個々のrefは負のままでよい)
execute if score #be_signed test.buff.work matches 0 if score #be_a12 test.buff.work matches ..-1 run data modify storage test: buff_eval.result set value {ok:1b,value:0}
execute if score #be_signed test.buff.work matches 0 if score #be_a12 test.buff.work matches ..-1 run data remove storage test: buff_eval.work
execute if score #be_signed test.buff.work matches 0 if score #be_a12 test.buff.work matches ..-1 run return 0

# signed: 0クランプせず、負の小計を大きさへ反転してpropagateし直し、signを-1にする。
# a12反転後は..-1判定が使えなくなるので、先にflipフラグへ結果を控える
scoreboard players set #be_flip test.buff.work 0
execute if score #be_signed test.buff.work matches 1 if score #be_a12 test.buff.work matches ..-1 run scoreboard players set #be_flip test.buff.work 1

execute if score #be_flip test.buff.work matches 1 run scoreboard players operation #be_a0 test.buff.work *= #be_neg1 test.buff.work
execute if score #be_flip test.buff.work matches 1 run scoreboard players operation #be_a1 test.buff.work *= #be_neg1 test.buff.work
execute if score #be_flip test.buff.work matches 1 run scoreboard players operation #be_a2 test.buff.work *= #be_neg1 test.buff.work
execute if score #be_flip test.buff.work matches 1 run scoreboard players operation #be_a3 test.buff.work *= #be_neg1 test.buff.work
execute if score #be_flip test.buff.work matches 1 run scoreboard players operation #be_a4 test.buff.work *= #be_neg1 test.buff.work
execute if score #be_flip test.buff.work matches 1 run scoreboard players operation #be_a5 test.buff.work *= #be_neg1 test.buff.work
execute if score #be_flip test.buff.work matches 1 run scoreboard players operation #be_a6 test.buff.work *= #be_neg1 test.buff.work
execute if score #be_flip test.buff.work matches 1 run scoreboard players operation #be_a7 test.buff.work *= #be_neg1 test.buff.work
execute if score #be_flip test.buff.work matches 1 run scoreboard players operation #be_a8 test.buff.work *= #be_neg1 test.buff.work
execute if score #be_flip test.buff.work matches 1 run scoreboard players operation #be_a9 test.buff.work *= #be_neg1 test.buff.work
execute if score #be_flip test.buff.work matches 1 run scoreboard players operation #be_a10 test.buff.work *= #be_neg1 test.buff.work
execute if score #be_flip test.buff.work matches 1 run scoreboard players operation #be_a11 test.buff.work *= #be_neg1 test.buff.work
execute if score #be_flip test.buff.work matches 1 run scoreboard players operation #be_a12 test.buff.work *= #be_neg1 test.buff.work
execute if score #be_flip test.buff.work matches 1 run function test:buff/eval/propagate
execute if score #be_flip test.buff.work matches 1 run scoreboard players set #be_sign test.buff.work -1

# maxがあるときだけ、大きさをmaxの桁と比べて上回っていれば置き換える(符号はこの後で乗せる)
execute if score #be_has_max test.buff.work matches 1 run scoreboard players operation #be_v test.buff.work = #be_max test.buff.work
execute if score #be_has_max test.buff.work matches 1 run function test:buff/eval/split
execute if score #be_has_max test.buff.work matches 1 run scoreboard players operation #be_c0 test.buff.work = #be_d0 test.buff.work
execute if score #be_has_max test.buff.work matches 1 run scoreboard players operation #be_c1 test.buff.work = #be_d1 test.buff.work
execute if score #be_has_max test.buff.work matches 1 run scoreboard players operation #be_c2 test.buff.work = #be_d2 test.buff.work
execute if score #be_has_max test.buff.work matches 1 run scoreboard players operation #be_c3 test.buff.work = #be_d3 test.buff.work
execute if score #be_has_max test.buff.work matches 1 run scoreboard players operation #be_c4 test.buff.work = #be_d4 test.buff.work
execute if score #be_has_max test.buff.work matches 1 run function test:buff/eval/cmp_bound

execute if score #be_has_max test.buff.work matches 1 if score #be_gt test.buff.work matches 1 run scoreboard players operation #be_a2 test.buff.work = #be_c0 test.buff.work
execute if score #be_has_max test.buff.work matches 1 if score #be_gt test.buff.work matches 1 run scoreboard players operation #be_a3 test.buff.work = #be_c1 test.buff.work
execute if score #be_has_max test.buff.work matches 1 if score #be_gt test.buff.work matches 1 run scoreboard players operation #be_a4 test.buff.work = #be_c2 test.buff.work
execute if score #be_has_max test.buff.work matches 1 if score #be_gt test.buff.work matches 1 run scoreboard players operation #be_a5 test.buff.work = #be_c3 test.buff.work
execute if score #be_has_max test.buff.work matches 1 if score #be_gt test.buff.work matches 1 run scoreboard players operation #be_a6 test.buff.work = #be_c4 test.buff.work
execute if score #be_has_max test.buff.work matches 1 if score #be_gt test.buff.work matches 1 run scoreboard players set #be_a7 test.buff.work 0
execute if score #be_has_max test.buff.work matches 1 if score #be_gt test.buff.work matches 1 run scoreboard players set #be_a8 test.buff.work 0
execute if score #be_has_max test.buff.work matches 1 if score #be_gt test.buff.work matches 1 run scoreboard players set #be_a9 test.buff.work 0
execute if score #be_has_max test.buff.work matches 1 if score #be_gt test.buff.work matches 1 run scoreboard players set #be_a10 test.buff.work 0
execute if score #be_has_max test.buff.work matches 1 if score #be_gt test.buff.work matches 1 run scoreboard players set #be_a11 test.buff.work 0
execute if score #be_has_max test.buff.work matches 1 if score #be_gt test.buff.work matches 1 run scoreboard players set #be_a12 test.buff.work 0

# 0クランプ後の小計は非負なので符号はsignそのもの。境界は2147483648がint32に収まらないのでc0だけ差し替える
scoreboard players operation #be_sgn test.buff.work = #be_sign test.buff.work

scoreboard players set #be_c0 test.buff.work 47
execute if score #be_sgn test.buff.work matches ..-1 run scoreboard players set #be_c0 test.buff.work 48
scoreboard players set #be_c1 test.buff.work 36
scoreboard players set #be_c2 test.buff.work 48
scoreboard players set #be_c3 test.buff.work 47
scoreboard players set #be_c4 test.buff.work 21

function test:buff/eval/cmp_bound

execute if score #be_gt test.buff.work matches 1 run data modify storage test: buff_eval.result set value {ok:0b,error:"out_of_range"}
execute if score #be_gt test.buff.work matches 1 run data remove storage test: buff_eval.work
execute if score #be_gt test.buff.work matches 1 run return 0

# 負の値から先に組み立てるとINT_MINまで桁あふれなく表現できる。正ならあとで反転する
scoreboard players set #be_out test.buff.work 0
scoreboard players operation #be_out test.buff.work *= #be_100 test.buff.work
scoreboard players operation #be_out test.buff.work -= #be_a6 test.buff.work
scoreboard players operation #be_out test.buff.work *= #be_100 test.buff.work
scoreboard players operation #be_out test.buff.work -= #be_a5 test.buff.work
scoreboard players operation #be_out test.buff.work *= #be_100 test.buff.work
scoreboard players operation #be_out test.buff.work -= #be_a4 test.buff.work
scoreboard players operation #be_out test.buff.work *= #be_100 test.buff.work
scoreboard players operation #be_out test.buff.work -= #be_a3 test.buff.work
scoreboard players operation #be_out test.buff.work *= #be_100 test.buff.work
scoreboard players operation #be_out test.buff.work -= #be_a2 test.buff.work

execute if score #be_sgn test.buff.work matches 1.. run scoreboard players operation #be_out test.buff.work *= #be_neg1 test.buff.work

data remove storage test: buff_eval.work
data modify storage test: buff_eval.result set value {ok:1b}
execute store result storage test: buff_eval.result.value int 1 run scoreboard players get #be_out test.buff.work
