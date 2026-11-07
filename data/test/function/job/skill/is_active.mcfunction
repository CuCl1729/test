#> test:job/skill/is_active
# @macro job/node: 職業スキル参照。今のレジストリで発動できる種類なら1、パッシブ(stat_bonus)なら0を返す。
# 一覧(バンドル・戦闘のスキル一覧)と発動の入口はすべてこれで判定する(取得後にシートの種類が変わっても、今の種類で決まる)

$execute if data storage test: asset.job.jobs[{id:"$(job)"}].skills[{id:"$(node)",kind:"stat_bonus"}] run return 0
return 1
