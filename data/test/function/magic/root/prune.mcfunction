#> test:magic/root/prune
# @macro id: 初回配布など持続物を1つも出さなかったルートの元帳を片付ける(refsが0のときだけ消す)。
# 持続物がまだ生きているルートは消さない
$execute if data storage test: magic_roots[{id:$(id),refs:0}] run data remove storage test: magic_roots[{id:$(id)}]
return 1
