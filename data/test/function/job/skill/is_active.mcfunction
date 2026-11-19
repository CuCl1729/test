#> test:job/skill/is_active
# @macro job/node: 職業スキル参照。今のレジストリで発動できる種類なら1、パッシブ(stat_bonus)なら0、
# ノード自体がレジストリに無ければ0を返す(習得済みフラグが残っていても削除済みノードは発動させない)。
# 一覧(バンドル・戦闘のスキル一覧)と発動の入口はすべてこれで判定する(取得後にシートの種類が変わっても、今の種類で決まる)

$execute unless data storage test: asset.job.jobs[{id:"$(job)"}].skills[{id:"$(node)"}] run return 0
$execute if data storage test: asset.job.jobs[{id:"$(job)"}].skills[{id:"$(node)",kind:"stat_bonus"}] run return 0
return 1
