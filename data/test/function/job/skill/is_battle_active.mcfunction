#> test:job/skill/is_battle_active
# @macro job/node: 職業スキル参照。test:job/skill/is_active が返す登録ノード/パッシブ判定の可否(習得状態の確認は呼び出し元の責務)に加え、
# magicノードは今のレシピが手番で使える組み合わせ(型・効果のどれにもbattle:0bが無い)かも見る。
# 一覧(戦闘中のスキル一覧)と発動の入口はすべてこれで絞る(通常の職業スキルは従来通り1/0のまま)

$execute store result score #job_battle_active test.job.work run function test:job/skill/is_active {job:"$(job)",node:"$(node)"}
execute if score #job_battle_active test.job.work matches 0 run return 0

$execute unless data storage test: asset.job.jobs[{id:"$(job)"}].skills[{id:"$(node)",kind:"magic"}] run return 1

data remove storage test: job_battle_query
$data modify storage test: job_battle_query set from storage test: asset.job.jobs[{id:"$(job)"}].skills[{id:"$(node)"}].params
execute unless data storage test: job_battle_query.recipe run return 0

return run function test:magic/recipe/battle_allowed with storage test: job_battle_query
