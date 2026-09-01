#> test:buff/stat/add
# @s = バフ保持者。@macro stat: ステータス名 / amount: 増やす量(HP等と同じく内部の100倍値)
#
# 「ステータスを増減させる」というよくある中身のための共通ヘルパー。
# test.status.<名前> を直接書くと、プレイヤーは status/update が装備から組み立て直すときに消えるため、
# 蓄積用の test.buff.<名前> を経由してから実効値を計算し直す
#
# ステータス以外(test.*_resist.debuff / test.def.debuff など、status/update が触らない修飾スコア)を
# 変えたい場合は、このヘルパーを通さずイベント関数から直接増減してよい

$scoreboard players add @s test.buff.$(stat) $(amount)
$function test:status/recalc {status:"$(stat)",op:"add",amount:$(amount)}
