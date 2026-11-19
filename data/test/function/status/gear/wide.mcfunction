#> test:status/gear/wide
# 内部。基礎・乗率・固定値の小計のどれかが32bitに収まらなかったとき(status_gear.p に読んだ部品のまま)。
# 小計を一度もスコアに作らず、元の部品を正確な核の項に展開する: 基礎B_i×10000、基礎B_i×乗率M_j、
# 固定値F_i×10000(flat は 0)。合計は核の中で正確に消し合うので、最終値が収まるなら必ず通る
data modify storage test: buff_eval.arg set value {terms:[],flat:0,refs:{}}
scoreboard players set #gear_i test.buff.work 0

# 基礎の部品 ×(10000 と乗率の各部品)
data modify storage test: status_gear.ex.pct set from storage test: status_gear.p.m
data modify storage test: status_gear.ex.pct prepend value 10000
data modify storage test: status_gear.ex.refs set from storage test: status_gear.p.b
function test:status/gear/ex_ref

# 乗率のあとに足す固定値の部品 ×10000(掛け算にはかからない)
data modify storage test: status_gear.ex.pct set value [10000]
data modify storage test: status_gear.ex.refs set from storage test: status_gear.p.f
function test:status/gear/ex_ref

data remove storage test: status_gear.ex
