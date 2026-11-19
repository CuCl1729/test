#> test:buff/actor/resolve_find
# 内部。@macro caster: 発生元の OhMyDatID。見つかったらその人として今の参照値を取る
#
# 探す範囲はプレイヤー全員と、読み込まれている非プレイヤー全員(距離を付けない @e は別の次元も見る)。
# 見つからないとき(消えた・まだ読み込まれていない)だけ呼び出し側が last_refs に落ちる

$execute as @a[scores={OhMyDatID=$(caster)},limit=1] run function test:buff/actor/resolve_one
$execute if score #ba_live test.buff.work matches 0 as @e[type=!player,scores={OhMyDatID=$(caster)},limit=1] run function test:buff/actor/resolve_one
