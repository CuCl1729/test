#> test:magic/buff/prepare
# storage test: magic_buff.src に入れたバフ一覧を、レジストリの kind を見て
#   magic_buff.debuff … 敵へ配るもの(kind:"debuff")
#   magic_buff.buff   … 味方へ配るもの(それ以外)
# へ振り分ける。srcが空でも必ず両方を空リストに作り直すので、
# 前に唱えた魔法のバフが残って誤爆することがない

data modify storage test: magic_buff.buff set value []
data modify storage test: magic_buff.debuff set value []

data modify storage test: magic_buff.queue set value []
execute if data storage test: magic_buff.src[0] run data modify storage test: magic_buff.queue set from storage test: magic_buff.src

function test:magic/buff/split_loop
