#> test:buff/resource/credit_seen
# 内部。マクロ {key:<身元の鍵>}。同じ鍵が seen に既にあれば #br_dup を 1 にする。
# 鍵は呼ぶ側が入れたものと同じ形なので、要素の部分一致はそのまま等しさになる

$execute if data storage test: buff_resource.seen[$(key)] run scoreboard players set #br_dup test.buff.work 1
