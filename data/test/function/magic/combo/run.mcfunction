#> test:magic/combo/run
# 当たった行(combo_work.hit)の挙動を、その行の params をマクロ引数にして呼ぶ。
# 挙動の中で数値を書かずに済むよう、行の params をそのまま渡す
#
# combo_work.call は共有の作業場なので、挙動の呼び出しは必ず最後の1行にしておくこと
# (挙動の中から別の組み合わせが実行されても、戻ってから読み直す値が無いようにするため)
data modify storage test: combo_work.call set from storage test: combo_work.hit.params
data modify storage test: combo_work.call.behavior set from storage test: combo_work.hit.behavior
function test:magic/combo/run_entry with storage test: combo_work.call
