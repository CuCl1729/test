#> test:job/skill/dispatch
# @s = 発動するプレイヤー。@macro kind/params: job_work.skill_entryから展開済み。
# 対応するハンドラ(test:job/skill/handler/<kind>)へparamsをそのまま渡す
# (ギミック/魔法タイプ/効果と同じ「宣言したidを関数名にして呼ぶ」ディスパッチ)

$function test:job/skill/handler/$(kind) with storage test: job_work.skill_entry.params
