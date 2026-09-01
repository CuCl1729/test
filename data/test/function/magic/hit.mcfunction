#> test:magic/hit
# @s = 魔法が当たった対象。全ての魔法ダメージ(投射の命中・着弾範囲・自分中心の範囲)がここを通る
# 詠唱者は一時タグdamage_attackerで参照する(投射は着弾が詠唱の数tick後になるため、
# projectile/moveがtest.ownerから詠唱者を引いてタグを付けている)

function test:damage/

function test:damage/display {verb:" の魔法！ "}

# 選んだデバフを対象へ付与する。振り分け済みの一覧は呼び出し元が用意している
# (ダメージ表示が使う#total_damage等を壊さないよう、必ず表示を出したあとに行う)
execute if data storage test: magic_buff.debuff[0] run data modify storage test: buff_work.pending set from storage test: magic_buff.debuff
execute if data storage test: magic_buff.debuff[0] run function test:buff/apply_list
