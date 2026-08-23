#> test:magic/hit
# @s = 魔法が当たった対象。全ての魔法ダメージ(投射の命中・着弾範囲・自分中心の範囲)がここを通る
# 詠唱者は一時タグdamage_attackerで参照する(投射は着弾が詠唱の数tick後になるため、
# projectile/moveがtest.ownerから詠唱者を引いてタグを付けている)

function test:damage/

function test:damage/display {verb:" の魔法！ "}
