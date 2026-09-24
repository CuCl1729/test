#> test:battle/action/job_skill_dispatch
# @s = 詠唱者(手番)。@macro kind/params: job_work.skill_entryから展開済み。
# 対応するターン制ハンドラ(test:battle/action/job_skill/handler/<kind>)へparamsをそのまま渡す

$function test:battle/action/job_skill/handler/$(kind) with storage test: job_work.skill_entry.params
