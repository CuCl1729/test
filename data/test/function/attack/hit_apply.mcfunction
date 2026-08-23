#> test:attack/hit_apply
# @s = ダメージを受けた対象(1体、tag=hit)。攻撃者は一時タグdamage_attackerで参照する。
# test:damage/を適用したあと、剣・魔法で共通のダメージ表示(test:damage/display)を呼ぶ

function test:damage/

function test:damage/display {verb:" の攻撃！ "}
