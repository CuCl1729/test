#> test:magic/combo/match
# 要素の組み合わせから「何になるか」を、スプレッドシート生成の表(asset.magic.combos)1つだけで決める。
# クラフトの検証・魔法台の説明・実行時のディスパッチが、すべてこの関数を通る
#
# 入力: storage test: combo_work.flags   使われた要素のバイトフラグ(status.type_flags と同じ形)
#       storage test: combo_work.apply   "stage"(1つの段の中) / "link"(段と段のつなぎ)
#       storage test: combo_work.emitter "player"(プレイヤーが直接唱えた) / "source"(設置物・弾が起こした)
# 出力: #combo_found test.temporary      1=当たる行があった
#       storage test: combo_work.hit     当たった行(behavior / params / desc / id)
#
# require をすべて含み forbid を1つも含まない行が当たる。表に無い組み合わせは成立しない
# (= 未定義の組み合わせは黙って既定動作に落ちず、必ず弾かれる)

scoreboard players set #combo_found test.temporary 0
data remove storage test: combo_work.hit
data modify storage test: combo_work.queue set from storage test: asset.magic.combos
function test:magic/combo/match_loop
