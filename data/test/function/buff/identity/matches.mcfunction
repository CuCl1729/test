#> test:buff/identity/matches
# 内部。@s = 調べたい実体。@macro uuid: 本物の UUID(IntArray)。
# 同じ実体なら #bi_match test.buff.work を1、別人なら0にする。
# OhMyDatID は死んだ非プレイヤーのぶんが使い回されるので、ID だけでは身元にならない
# (引き当てる鍵は ID のまま。UUID は「本当に同じ人か」の確認だけに使う)

scoreboard players set #bi_match test.buff.work 0
$execute if data entity @s {UUID:$(uuid)} run scoreboard players set #bi_match test.buff.work 1
